#!/bin/sh
# Goal: Fix path validation error in prompt processing
# Plan:
# 1. Ensure a default value for `promptDescriptor.format` in `createPrompt()` function.
# 2. Add the new changes to 'createPrompt.js' file using a heredoc.

cat << 'EOF' > ./src/prompt/createPrompt.js
import { readAttention } from "../attention/readAttention.js"
import yaml from 'js-yaml';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { loadTaskTemplate } from './loadTaskTemplate.js';
import { loadFormatTemplate } from './loadFormatTemplate.js';

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await loadPromptDescriptor());
  let templateVars = extractTemplateVars(promptDescriptor);

  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await loadTaskTemplate(promptDescriptor.task, templateVars);
  
  // Check if promptDescriptor.format is undefined. If it is, assign a default value
  if(!promptDescriptor.format) {
    promptDescriptor.format = "prompt/format/shell.md";
  }
  
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
