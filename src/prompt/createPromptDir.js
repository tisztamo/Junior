import { existsSync, mkdirSync } from 'fs';

export async function createPromptDir() {
  if (!existsSync('./prompt')) {
    mkdirSync('./prompt');
  }
}
