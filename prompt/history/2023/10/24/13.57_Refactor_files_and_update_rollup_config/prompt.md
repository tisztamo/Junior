You are AI Junior, you code like Donald Knuth.

# Working set

./package.json:
```
{
  "name": "@aijunior/dev",
  "version": "0.3.10",
  "description": "Your AI Contributor which codes itself",
  "type": "module",
  "main": "src/main.js",
  "bin": {
    "junior": "bin/web.js",
    "junior-web": "bin/web.js",
    "junior-cli": "bin/cli.js",
    "junior-init": "bin/init.js",
    "junior-rollback": "bin/junior-rollback.js",
    "junior-news": "bin/readGitHistoryToMd.js"
  },
  "scripts": {
    "cli": "node scripts/cli.js",
    "start": "node scripts/dev.js",
    "update-logo": "node ./scripts/updateLogo.js",
    "clear-branches": "node ./scripts/clearBranchesCommand.js $@",
    "test": "cypress open",
    "rollback": "node scripts/junior-rollback.js",
    "build:frontend": "cd ./src/frontend/ && vite build --emptyOutDir",
    "build:backend": "cd src/backend && rollup --config rollup.config.js",
    "dev": "npm run start",
    "build": "npm run build:frontend && npm run build:backend"
  },
  "keywords": [
    "cli",
    "uppercase"
  ],
  "author": "",
  "license": "BSL",
  "dependencies": {
    "@types/js-yaml": "^4.0.5",
    "autoprefixer": "^10.4.14",
    "chatgpt": "^5.2.4",
    "cors": "^2.8.5",
    "ejs": "^3.1.9",
    "express": "^4.18.2",
    "highlight.js": "^11.8.0",
    "js-yaml": "^4.1.0",
    "markdown-it": "^13.0.1",
    "marked": "^5.1.0",
    "node-pty": "^1.0.0",
    "sharp": "^0.32.4",
    "simple-git": "^3.19.1",
    "solid-js": "^1.7.7",
    "tailwindcss": "^3.3.3",
    "ws": "^8.13.0",
    "xterm": "^5.3.0"
  },
  "directories": {
    "doc": "docs"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/tisztamo/Junior.git"
  },
  "bugs": {
    "url": "https://github.com/tisztamo/Junior/issues"
  },
  "homepage": "https://github.com/tisztamo/Junior#readme",
  "devDependencies": {
    "cypress": "^13.0.0",
    "@rollup/plugin-node-resolve": "^15.2.3",
    "postcss": "^8.4.26",
    "postcss-nested": "^6.0.1",
    "vite": "^4.3.9",
    "vite-plugin-solid": "^2.7.0"
  },
  "files": [
    "dist/",
    "prompt/",
    "scripts/"
  ]
}

```
./bin/web.js:
```
#!/usr/bin/env node

import fs from 'fs';
import { execSync } from 'child_process';
import path from 'path';

async function main() {
    // Determine the project root based on the current script location using import.meta
    const scriptDir = path.dirname(import.meta.url).replace('file://', '');
    const projectRoot = path.join(scriptDir, '..');

    // Check for dist/ directory
    const distDir = path.join(projectRoot, 'dist');
    if (!fs.existsSync(distDir)) {
        console.log('Note: dist/ directory does not exist. Running npm run build...');
        execSync('npm run build', { stdio: 'inherit', cwd: projectRoot });
    }

    // Dynamically import startServer from dist/backend/startServer.js
    const { startServer } = await import(path.join(distDir, 'backend/startServer.js'));
    startServer();
}

main();


```
./bin/junior-rollback.js:
```
#!/usr/bin/env node
import resetGit from '../src/git/resetGit.js';

async function executeRollback() {
  try {
    await resetGit();
  } catch (err) {
    console.error();
  }
}

executeRollback();

```
./src/backend/rollup.config.js:
```
import { nodeResolve } from '@rollup/plugin-node-resolve';

const commonConfig = {
  output: {
    format: 'esm'
  },
  plugins: [
    nodeResolve({
      preferBuiltins: true,
    })
  ],
  external: [/node_modules/]
};

export default [
  {
    ...commonConfig,
    input: './startServer.js',
    output: {
      ...commonConfig.output,
      dir: '../../dist/backend/'
    }
  },
  {
    ...commonConfig,
    input: '../../scripts/init.js',
    output: {
      ...commonConfig.output,
      dir: '../../dist/scripts/'
    }
  }
];

```

# Task

Refactor!

- Rename junior-rollback.js to rollback.js and create a new entry for it in the rollup config
- init.js was moved from scripts to bin. Update the rollup config accordingly


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END

