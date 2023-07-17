import fs from 'fs/promises';
import { loadPromptFile } from './loadPromptFile.js';

async function getSystemPrompt() {
  return (await loadPromptFile("prompt/system.md", {})).toString();
}

export { getSystemPrompt };
