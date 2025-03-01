You are a senior software developer, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

We are executing a shell script here to make changes on the file system. On Windows, we need a way for this to run properly. e.g. in git bash the script works. Find a way to install a working bash together with our package and execute the script with it on Windows. 


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: Debian


Installed tools: npm, jq




EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"

# Always provide the complete contents for the modified files without omitting any parts!
cat > x.js << EOF
  let i = 1
  console.log(\`i: \${i}\`)
EOF
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

# Working set

src/backend/handlers/executeHandler.js:
```
import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';
import { extractCode } from '../../execute/extractCode.js';

async function executeHandler(req, res) {
  let code = req.body.change;

  // Check if code starts with shebang
  if (!code.startsWith("#!")) {
    code = extractCode(code);
  }
  
  await executeAndForwardOutput(code, (code, output) => {
    res.json({ output });
  });
}

export { executeHandler };


```
src/execute/executeAndForwardOutput.js:
```
import { writeFile } from 'fs/promises';
import { spawn } from 'child_process';
import { makeExecutable } from './makeExecutable.js';
import { saveAuditTrail } from './saveAuditTrail.js';

async function executeAndForwardOutput(code, next) {
    try {
        if (code == null || !code.startsWith('#!')) {
            throw new Error('Code does not start with a shebang');
        }
        
        await saveAuditTrail(code);

        await writeFile('./change.sh', code);
        await makeExecutable('./change.sh');
        
        const child = spawn('./change.sh', [], { shell: true });
        let commandOutput = '';

        child.stdout.on('data', (data) => {
            console.log(`${data}`);
            commandOutput += data;
        });

        child.stderr.on('data', (data) => {
            console.error(`${data}`);
            commandOutput += data;
        });

        child.on('close', (code) => {
            if (next && typeof next === 'function') {
                next(code, commandOutput);
            }
        });
    } catch (err) {
        console.log(err);
    }
}

export { executeAndForwardOutput };

```
package.json:
```
{
  "name": "@aijunior/dev",
  "version": "0.3.22",
  "description": "Your AI Contributor which codes itself",
  "type": "module",
  "main": "src/main.js",
  "bin": {
    "junior": "dist/bin/web.js",
    "junior-web": "dist/bin/web.js",
    "junior-cli": "dist/bin/cli.js",
    "junior-init": "dist/bin/init.js",
    "junior-rollback": "dist/bin/rollback.js",
    "junior-news": "dist/bin/readGitHistoryToMd.js"
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
    "build": "npm run build:frontend && npm run build:backend",
    "postinstall": "node scripts/postinstall.js"
  },
  "keywords": [
    "cli",
    "uppercase"
  ],
  "author": "",
  "license": "MIT",
  "dependencies": {
    "@homebridge/node-pty-prebuilt-multiarch": "^0.11.14",
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
    "sanitize-filename": "^1.6.3",
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
    "@rollup/plugin-node-resolve": "^15.2.3",
    "postcss": "^8.4.26",
    "postcss-nested": "^6.0.1",
    "rollup-plugin-preserve-shebang": "^1.0.1",
    "vite": "^4",
    "vite-plugin-solid": "^2"
  },
  "files": [
    "dist/",
    "prompt/",
    "scripts/"
  ]
}

```