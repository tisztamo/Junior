import fs from 'fs';
import path from 'path';
import { createPromptYaml } from './createPromptYaml.js';
import { juniorInit } from '../git/juniorInit.js';

export async function prepareDirForJunior() {
  const promptDir = path.join(process.cwd(), 'prompt');

  if (!fs.existsSync(promptDir)) {
    console.warn('\x1b[33mWarning: Initializing Junior...\x1b[0m');
    await juniorInit();
  } else {
    const promptYaml = path.join(promptDir, 'prompt.yaml');
    if (!fs.existsSync(promptYaml)) {
      createPromptYaml();
    }
  }
}
