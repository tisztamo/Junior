import { createPrompt } from './createPrompt.js';
import fs from 'fs/promises';

const generatePrompt = async (notes, forceSystemPrompt = false, saveto = 'prompt.md', parent_message_id = null) => {
  const { prompt, saveto: newSaveto } = await createPrompt(notes, forceSystemPrompt);
  await fs.writeFile(newSaveto || saveto, prompt);
  return { prompt, parent_message_id };
}

export default generatePrompt;
