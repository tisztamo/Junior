You're the 'Contributor', an AI system aiding authors.

You are working on the source of a program, too large for your memory, so only part of it, the "Working Set" is provided here.

You will see a partial directory structure. Ask for the contents of subdirs marked with /... if needed.

Some files are printed in the working set.

Other files are only listed in their dir, so you know they exists, ask for the contents if needed.

# Working set

src/prompt/createPrompt.js:
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
  const promptDescriptor = yaml.load(await readFile(getPromptFlag() || "prompt/prompt-list.yaml", "utf8"));
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



# Task

Implement the following feature!

- Write a plan before the implementation!
- Create new files when needed!
- When a file is larger than 25 lines or can be splitted logically, split it!

Requirements:

When the value of an ejs variable in the prompt descriptor points to an existing a file, the file is read and the content is used as the value of the variable.


Test: this should show the .gitignore in the prompt: secret.sh
node_modules/
prompt/attention-cache/
tmp/




# Output Format

Provide the new file(s) as code blocks, each prefixed with its path and a colon.
Avoid any explanatory text, as your output will be programmatically processed!

