# Working set

```
./
├── .DS_Store
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── README.md
├── change.sh
├── docs/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── scripts/...
├── src/...
├── x.sh

```
```
scripts/
├── updateLogo.js

```
src/git/deleteBranches.js:
```
import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function deleteBranches(exceptions = []) {
  try {
    const { stdout: currentBranch } = await exec('git rev-parse --abbrev-ref HEAD');
    const { stdout: allBranches } = await exec('git for-each-ref --format="%(refname:short)" refs/heads');

    const branches = allBranches.split('\n').filter(branch => branch !== currentBranch.trim() && !exceptions.includes(branch));

    for (const branch of branches) {
      await executeCommand(`git branch -d ${branch}`);
    }
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

async function executeCommand(command) {
  try {
    console.log(`Running command: ${command}`);
    const { stdout } = await exec(command);
    console.log(`stdout: ${stdout}`);
  } catch (err) {
    throw err;
  }
}

```

package.json:
```
{
  "name": "@aijunior/dev",
  "version": "0.1.3",
  "description": "Your AI Contributor which codes itself",
  "type": "module",
  "main": "src/main.js",
  "bin": {
    "junior": "src/main.js",
    "junior-web": "src/web.js",
    "junior-init": "src/init.js"
  },
  "scripts": {
    "cli": "node src/main.js",
    "start": "node src/web.js",
    "build:css": "postcss ./src/frontend/styles.css -o ./dist/styles.css",
    "update-logo": "node ./scripts/updateLogo.js"
  },
  "keywords": [
    "cli",
    "uppercase"
  ],
  "author": "",
  "license": "GPL",
  "dependencies": {
    "@types/js-yaml": "^4.0.5",
    "autoprefixer": "^10.4.14",
    "chatgpt": "^5.2.4",
    "cors": "^2.8.5",
    "docsify-cli": "^4.4.4",
    "ejs": "^3.1.9",
    "express": "^4.18.2",
    "highlight.js": "^11.8.0",
    "js-yaml": "^4.1.0",
    "markdown-it": "^13.0.1",
    "marked": "^5.1.0",
    "postcss": "^8.4.26",
    "postcss-nested": "^6.0.1",
    "sharp": "^0.32.4",
    "simple-git": "^3.19.1",
    "solid-js": "^1.7.7",
    "tailwindcss": "^3.3.3",
    "vite": "^4.3.9",
    "vite-plugin-solid": "^2.7.0",
    "ws": "^8.13.0"
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
  "homepage": "https://github.com/tisztamo/Junior#readme"
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create a command for this function!
Pass arguments!



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

