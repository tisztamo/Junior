import fs from 'fs';
import path from 'path';
import { createPromptYaml } from './createPromptYaml.js';
import { juniorInit } from '../git/juniorInit.js';
import { descriptorFileName } from './promptDescriptorConfig.js'; // Import the descriptor file name

export async function prepareDirForJunior() {
  const promptDir = path.join(process.cwd(), 'prompt');

  if (!fs.existsSync(promptDir)) {
    console.warn('\x1b[33mWarning: Initializing Junior...\x1b[0m');
    await juniorInit();
  } else {
    const promptYaml = path.join(process.cwd(), descriptorFileName); // Use the descriptor file name from the config, relative to the current directory
    if (!fs.existsSync(promptYaml)) {
      createPromptYaml();
    }
  }
}
