import { fileURLToPath } from 'url';
import createGitignore from './createGitignore.js';
import { createPromptYaml } from '../prompt/createPromptYaml.js';
import { createPromptDir } from '../prompt/createPromptDir.js';
import copyDefaults from '../command/init/copyDefaults.js';
import checkAndInitRepo from './checkAndInitRepo.js';
import commitGit from './commitGit.js';
import path from 'path';
import isRepoClean from './isRepoClean.js';
import getProjectRoot from '../backend/fileutils/getProjectRoot.js';
import { createReadme } from '../prompt/createReadme.js';

export async function juniorInit() {
  await checkAndInitRepo();

  if (!await isRepoClean()) {
    console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
    process.exit(1);
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();
  createReadme();

  const projectRoot = getProjectRoot();
  const defaultsPath = path.join(projectRoot, 'prompt/defaults/');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}
