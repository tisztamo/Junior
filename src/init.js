#!/usr/bin/env node
import { execSync } from 'child_process';
import { join } from 'path';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createProjectSpecifics } from './prompt/createProjectSpecifics.js';
import { createGitignore } from './git/createGitignore.js';

async function juniorInit() {
  execSync('git init', { stdio: 'inherit' });

  createGitignore();

  execSync('git add .gitignore', { stdio: 'inherit' });
  execSync('git commit -m "Junior init"', { stdio: 'inherit' });

  createPromptYaml();
  createProjectSpecifics();

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
