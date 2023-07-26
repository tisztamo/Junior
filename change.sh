#!/bin/sh
set -e
goal="Modify defaults to load from files"
echo "Plan:"
echo "1. Create the necessary files in the prompt/ directory with appropriate contents"
echo "2. Modify the promptDescriptorDefaults.js file to import loadPromptFile and load the file contents into the default object"
echo "3. Modify the createPrompt.js file to accommodate the changes in the promptDescriptorDefaults.js"

# Step 1: Create the necessary files in the prompt/ directory with appropriate contents
mkdir -p prompt

cat << 'EOF' > ./prompt/format.md
prompt/format/shell.md
EOF

cat << 'EOF' > ./prompt/os.md
Debian
EOF

cat << 'EOF' > ./prompt/installedTools.md
npm, jq
EOF

# Step 2: Modify the promptDescriptorDefaults.js file to import loadPromptFile and load the file contents into the default object
cat << 'EOF' > ./src/prompt/promptDescriptorDefaults.js
import { loadPromptFile } from './loadPromptFile.js';

const loadDefaults = async () => {
  let promptDescriptorDefaults = {};
  const files = ['format', 'os', 'installedTools'];
  for (let file of files) {
    promptDescriptorDefaults[file] = await loadPromptFile(`prompt/${file}.md`);
  }
  return promptDescriptorDefaults;
}

export default loadDefaults;
EOF

# Step 3: Modify the createPrompt.js file to accommodate the changes in the promptDescriptorDefaults.js
cat << 'EOF' > ./src/prompt/createPrompt.js
import { readAttention } from "../attention/readAttention.js"
import yaml from 'js-yaml';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { loadTaskTemplate } from './loadTaskTemplate.js';
import { loadFormatTemplate } from './loadFormatTemplate.js';
import loadDefaults from './promptDescriptorDefaults.js';

const createPrompt = async (userInput) => {
  let promptDescriptorDefaults = await loadDefaults();
  let promptDescriptor = yaml.load(await loadPromptDescriptor());

  // Fill in the defaults from promptDescriptorDefaults.js
  promptDescriptor = { ...promptDescriptorDefaults, ...promptDescriptor };

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
