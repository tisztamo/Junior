#!/bin/sh
set -e
goal="Ensure repo is clean before prompt generation"
echo "Plan:"
echo "1. Create a new isRepoClean.js function to check if the repository is clean."
echo "2. Modify the init.js to utilize the isRepoClean.js function."
echo "3. Modify the generateHandler.js to utilize the isRepoClean.js function before generating the prompt."

# Step 1: Create isRepoClean.js
cat > ./src/git/isRepoClean.js << 'EOF'
import simpleGit from 'simple-git';

const git = simpleGit();

const isRepoClean = async () => {
  const isRepo = await git.checkIsRepo();

  if (!isRepo) {
    return false;
  }

  const status = await git.status();
  return status.isClean();
}

export default isRepoClean;
EOF

# Step 2: Modify init.js to use isRepoClean.js
cat > ./src/init.js << 'EOF'
#!/usr/bin/env node
import simpleGit from 'simple-git';
import { fileURLToPath } from 'url';
import { createPromptYaml } from './prompt/createPromptYaml.js';
import { createGitignore } from './git/createGitignore.js';
import { createPromptDir } from './prompt/createPromptDir.js';
import copyDefaults from './command/init/copyDefaults.js';
import path from 'path';
import isRepoClean from './git/isRepoClean.js';

const git = simpleGit();

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

  await git.add('.');
  await git.commit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
EOF

# Step 3: Modify generateHandler.js to use isRepoClean.js before generating the prompt.
cat > ./src/backend/handlers/generateHandler.js << 'EOF'
import processPrompt from '../../prompt/processPrompt.js';
import isRepoClean from '../../git/isRepoClean.js';

export const generateHandler = async (req, res) => {
  try {
    if (!await isRepoClean()) {
      throw new Error("Directory is not clean. Please commit or stash changes and try again.");
    }

    const { notes, systemPrompt } = req.body;
    const { prompt } = await processPrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    res.status(500).json({ error: error.message });
  }
};
EOF

echo "\033[32mDone: $goal\033[0m\n"