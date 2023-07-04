import { readAttention } from "../attention/readAttention.js"
import util from 'util';
import fs from 'fs';
import yaml from 'js-yaml';
import ejs from 'ejs';
import { getPromptFlag } from './getPromptFlag.js';
import { getSystemPromptIfNeeded } from './getSystemPromptIfNeeded.js';
import { resolveTemplateVariables } from './resolveTemplateVariables.js';
import { extractTemplateVars } from './extractTemplateVars.js';
const readFile = util.promisify(fs.readFile);

const createPrompt = async (userInput) => {
  const promptDescriptor = yaml.load(await readFile(getPromptFlag() || "current_prompt.yaml", "utf8"));
  let templateVars = extractTemplateVars(promptDescriptor);

  templateVars = await resolveTemplateVariables(templateVars);

  const attention = await readAttention(promptDescriptor.attention);
  const task = await ejs.renderFile(promptDescriptor.task, templateVars, {async: true});
  const format = await ejs.renderFile(promptDescriptor.format, templateVars, {async: true});
  const system = await getSystemPromptIfNeeded();
  const saveto = promptDescriptor.saveto;
  return {
    prompt: `${system}# Working set\n\n${attention.join("\n")}\n\n# Task\n\n${task}\n\n# Output Format\n\n${format}\n\n${userInput ? userInput : ""}`,
    saveto
  };
}

export { createPrompt };
