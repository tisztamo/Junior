#!/bin/sh
set -e
goal="Refactor loadDefaults function in promptDescriptorDefaults.js"
echo "Plan:"
echo "1. Rename the loadDefaults function to promptDescriptorDefaults in promptDescriptorDefaults.js"
echo "2. Implement functionality to dynamically load .md files from prompt/ directories in the promptDescriptorDefaults.js"
echo "3. Adjust the export in the createPrompt.js file to account for the renamed function"
echo "4. Implement a new function in a new file getPromptDirectories.js which returns the prompt directories."

cat > ./src/prompt/promptDescriptorDefaults.js << 'EOF'
import { loadPromptFile } from './loadPromptFile.js';
import { getPromptDirectories } from './getPromptDirectories.js';
import fs from 'fs';
import path from 'path';

const promptDescriptorDefaults = async () => {
  let promptDescriptorDefaults = {};
  
  const promptDirs = getPromptDirectories();

  for(let dir of promptDirs) {
    const files = fs.readdirSync(dir).filter(file => file.endsWith('.md'));

    for (let file of files) {
      const fileNameWithoutExtension = path.basename(file, '.md');
      promptDescriptorDefaults[fileNameWithoutExtension] = await loadPromptFile(`prompt/${file}`);
    }
  }
  return promptDescriptorDefaults;
}

export default promptDescriptorDefaults;
EOF

echo "./src/prompt/promptDescriptorDefaults.js has been updated"

cat > ./src/prompt/createPrompt.js << 'EOF'
import { readAttention } from "../attention/readAttention.js"
import yaml from 'js-yaml';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { loadTaskTemplate } from './loadTaskTemplate.js';
import { loadFormatTemplate } from './loadFormatTemplate.js';
import promptDescriptorDefaults from './promptDescriptorDefaults.js';

const createPrompt = async (userInput) => {
  let promptDescriptorDefaultsData = await promptDescriptorDefaults();
  let promptDescriptor = yaml.load(await loadPromptDescriptor());

  // Fill in the defaults from promptDescriptorDefaults.js
  promptDescriptor = { ...promptDescriptorDefaultsData, ...promptDescriptor };

  let templateVars = extractTemplateVars(promptDescriptor);
  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await loadTaskTemplate(promptDescriptor.task, templateVars);

  const format = await loadFormatTemplate(promptDescriptor.format, templateVars);
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };
EOF

echo "./src/prompt/createPrompt.js has been updated"

cat > ./src/prompt/getPromptDirectories.js << 'EOF'
import path from 'path';

const getPromptDirectories = () => {
  const rootDir = path.resolve();
  const workingDir = process.cwd();
  
  return [
    path.join(rootDir, 'prompt'),
    path.join(workingDir, 'prompt')
  ];
}

export { getPromptDirectories };
EOF

echo "./src/prompt/getPromptDirectories.js has been created"

echo "\033[32mDone: $goal\033[0m\n"
