#!/bin/sh
# Goal: Factor out promptDescriptor defaults to a separate file
# Plan:
# 1. Create a new file promptDescriptorDefaults.js
# 2. Add the default handling of the format and add defaults for "os" and "installedTools"
# 3. Modify createPrompt.js to import and use the defaults from promptDescriptorDefaults.js

# Step 1: Create promptDescriptorDefaults.js
cat > ./src/prompt/promptDescriptorDefaults.js << 'EOF'
const promptDescriptorDefaults = {
  format: "prompt/format/shell.md",
  os: "Debian",
  installedTools: "npm, jq"
};

export default promptDescriptorDefaults;
EOF

# Step 2: Modify createPrompt.js to import and use the defaults
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

# Task solved
echo "Task solved."
