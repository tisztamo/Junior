#!/bin/sh
set -e
goal="Implement prompt template system"
echo "Plan:"
echo "1. Create prompt/task.ejs with template contents."
echo "2. Modify createPrompt function to use new template."
echo "3. Combine template vars and constants into a single object."

# Step 1: Create prompt/task.ejs
cat > src/prompt/task.ejs << 'EOF'
<%- system %>

# Working set

<%- attention.join("\n") %>

# Task

<%- task %>

# Output Format

<%- format %>

<%- userInput ? userInput.trim() : "" %>
EOF

# Step 2: Modify createPrompt.js
cat > src/prompt/createPrompt.js << 'EOF'
import { readAttention } from "../attention/readAttention.js";
import yaml from 'js-yaml';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
import { loadPromptFile } from './loadPromptFile.js';
import { loadTaskTemplate } from './loadTaskTemplate.js';  // Added missing import
import { loadFormatTemplate } from './loadFormatTemplate.js';  // Added missing import
import promptDescriptorDefaults from './promptDescriptorDefaults.js';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';

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

  templateVars = { ...templateVars, attention, task, format, system, userInput };

  const filledTemplate = await loadPromptFile('src/prompt/task.ejs', templateVars);
  const saveto = promptDescriptor.saveto;

  return {
    prompt: filledTemplate.trim(),
    saveto
  };
}

export { createPrompt };
EOF

echo "\033[32mDone: $goal\033[0m\n"