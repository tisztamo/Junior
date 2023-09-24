#!/bin/sh
set -e
goal="Implement prompt formatting features"
echo "Plan:"
echo "1. Update the createPrompt function in createPrompt.js to trim the injected strings and add two newlines after the system prompt."

cat > ./src/prompt/createPrompt.js << 'EOF'
import { readAttention } from "../attention/readAttention.js";
import yaml from 'js-yaml';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { loadTaskTemplate } from './loadTaskTemplate.js';
import { loadFormatTemplate } from './loadFormatTemplate.js';
import promptDescriptorDefaults from './promptDescriptorDefaults.js';

const createPrompt = async (userInput, forceSystemPrompt) => {
  let promptDescriptor = yaml.load(await loadPromptDescriptor());
  let promptDescriptorDefaultsData = await promptDescriptorDefaults();

  promptDescriptor = { ...promptDescriptorDefaultsData, ...promptDescriptor };

  let templateVars = extractTemplateVars(promptDescriptor);
  templateVars = await resolveTemplateVariables(templateVars);

  const attention = (await readAttention(promptDescriptor.attention)).map(str => str.trim());
  const task = (await loadTaskTemplate(promptDescriptor.task, templateVars)).trim();
  const format = (await loadFormatTemplate(promptDescriptor.format, templateVars)).trim();
  const system = (await getSystemPromptIfNeeded(forceSystemPrompt)).trim();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}\n\n# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput.trim() : ""}`,
    saveto
  };
}

export { createPrompt };
EOF

echo "\033[32mDone: $goal\033[0m\n"