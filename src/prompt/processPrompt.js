import { createPrompt } from './createPrompt.js';
import fs from 'fs/promises';

const processPrompt = async (task, forceSystemPrompt = false, saveto = 'prompt.md', parent_message_id = null) => {
  const { prompt, saveto: newSaveto } = await createPrompt(task, forceSystemPrompt);
  await fs.writeFile(newSaveto || saveto, prompt);
  return { prompt, parent_message_id };
}

export default processPrompt;
