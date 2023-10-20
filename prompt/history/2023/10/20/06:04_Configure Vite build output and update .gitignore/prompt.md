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
    "junior": "scripts/main.js",
    "junior-web": "scripts/web.js",
    "junior-init": "scripts/init.js",
    "junior-rollback": "scripts/junior-rollback.js",
    "junior-news": "scripts/readGitHistoryToMd.js"
  },
  "scripts": {
    "cli": "node scripts/main.js",
    "start": "node scripts/web.js",
    "update-logo": "node ./scripts/updateLogo.js",
    "clear-branches": "node ./scripts/clearBranchesCommand.js $@",
    "test": "cypress open",
    "rollback": "node scripts/junior-rollback.js",
    "build:frontend": "cd ./src/frontend/ && vite build"
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
    "postcss": "^8.4.26",
    "postcss-nested": "^6.0.1",
    "sharp": "^0.32.4",
    "simple-git": "^3.19.1",
    "solid-js": "^1.7.7",
    "tailwindcss": "^3.3.3",
    "vite": "^4.3.9",
    "vite-plugin-solid": "^2.7.0",
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
    "cypress": "^13.0.0"
  }
}

```
./src/frontend/vite.config.js:
```
import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'

const __dirname = dirname(fileURLToPath(import.meta.url))

export default defineConfig({
  plugins: [solidPlugin()],
  css: {
    postcss: join(__dirname, 'postcss.config.cjs'),
  },
  build: {
    target: 'esnext',
  },
})

```
./.gitignore:
```
/secret.sh
/node_modules/
/tmp/
/prompt.yaml
/prompt.md
/change.sh

node_modules

# Backup patterns for .md files
*.md.backup
*.md.bak
*_backup.md
*.md~
*.md.tmp
*.md.old
*.md.orig
*.md.save

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Configure vite to put the build output to ./dist/fronted/ in the project root (two levels up from the vite config)
- gitignore dist/


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

