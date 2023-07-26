#!/bin/sh
set -e
goal="Optimize prompt file loading"
echo "Plan:"
echo "1. Modify the 'promptDescriptorDefaults.js' to create a list of unique filenames before loading them."
echo "2. Change the 'createPrompt.js' to handle the new way 'promptDescriptorDefaults.js' works."

# Change the promptDescriptorDefaults.js file
cat > src/prompt/promptDescriptorDefaults.js << 'EOF'
import { loadPromptFile } from './loadPromptFile.js';
import { getPromptDirectories } from './getPromptDirectories.js';
import fs from 'fs';
import path from 'path';

const promptDescriptorDefaults = async () => {
  let promptDescriptorDefaults = {};
  
  const promptDirs = getPromptDirectories();
  let uniqueFiles = new Set();

  // Store all unique file names
  for(let dir of promptDirs) {
    const files = fs.readdirSync(dir).filter(file => file.endsWith('.md'));
    files.forEach(file => uniqueFiles.add(file));
  }

  // Load only unique files
  for (let file of uniqueFiles) {
    const fileNameWithoutExtension = path.basename(file, '.md');
    promptDescriptorDefaults[fileNameWithoutExtension] = await loadPromptFile(`prompt/${file}`);
  }
  
  return promptDescriptorDefaults;
}

export default promptDescriptorDefaults;
EOF

# Change the createPrompt.js file
cat > src/prompt/createPrompt.js << 'EOF'
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

echo "\033[32mDone: $goal\033[0m\n"
