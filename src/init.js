#!/usr/bin/env node
import { fileURLToPath } from 'url';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import copyDefaults from './command/init/copyDefaults.js';
import isRepo from './git/isRepo.js';
import getStatus from './git/getStatus.js';
import initRepo from './git/initRepo.js';
import commitGit from './git/commitGit.js';
import path from 'path';
import isRepoClean from './git/isRepoClean.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  if (!await isRepoClean()) {
    console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
    process.exit(1);
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  const defaultsPath = path.join(__dirname, '../prompt/defaults');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
