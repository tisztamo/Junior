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

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  const repoExists = await isRepo();

  if (repoExists) {
    const status = await getStatus();
    if (!status.isClean()) {
      console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
      process.exit(1);
    }
  } else {
    await initRepo();
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
