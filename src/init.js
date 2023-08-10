#!/usr/bin/env node
import { execSync } from 'child_process';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import copyDefaults from './command/init/copyDefaults.js';
import path from 'path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  execSync('git init', { stdio: 'inherit' });

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  // Correcting the path to the prompt/defaults folder in the installed version of Junior
  const defaultsPath = path.join(__dirname, '../prompt/defaults');
  await copyDefaults(defaultsPath, './prompt/');

  execSync('git add .', { stdio: 'inherit' });
  execSync('git commit -m "Junior init"', { stdio: 'inherit' });

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
