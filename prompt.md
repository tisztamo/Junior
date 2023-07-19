# Working set

```
integrations/vscode/
├── .eslintrc.json
├── .gitignore
├── .vscode/...
├── .vscodeignore
├── CHANGELOG.md
├── README.md
├── node_modules/...
├── out/...
├── package-lock.json
├── package.json
├── src/...
├── tsconfig.json
├── vsc-extension-quickstart.md

```
integrations/vscode/package.json:
```
{
  "name": "junior",
  "displayName": "Junior",
  "description": "Your AI contributor",
  "version": "0.0.1",
  "engines": {
    "vscode": "^1.80.0"
  },
  "categories": [
    "Other"
  ],
  "activationEvents": [],
  "main": "./out/extension.js",
  "contributes": {
    "commands": [
      {
        "command": "junior.helloWorld",
        "title": "Hello World"
      },
      {
        "command": "junior.writeAttention",
        "title": "Write Attention"
      }
    ]
  },
  "scripts": {
    "vscode:prepublish": "npm run compile",
    "compile": "tsc -p ./",
    "watch": "tsc -watch -p ./",
    "pretest": "npm run compile && npm run lint",
    "lint": "eslint src --ext ts",
    "test": "node ./out/test/runTest.js"
  },
  "devDependencies": {
    "@types/glob": "^8.1.0",
    "@types/mocha": "^10.0.1",
    "@types/node": "20.2.5",
    "@types/vscode": "^1.80.0",
    "@typescript-eslint/eslint-plugin": "^5.59.8",
    "@typescript-eslint/parser": "^5.59.8",
    "@vscode/test-electron": "^2.3.2",
    "eslint": "^8.41.0",
    "glob": "^8.1.0",
    "mocha": "^10.2.0",
    "typescript": "^5.1.3"
  },
  "dependencies": {
    "js-yaml": "^4.1.0"
  }
}

```

integrations/vscode/src/writeAttention.ts:
```
import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';
import * as yaml from 'js-yaml';

export const writeAttention = async () => {
    const workspaceFolders = vscode.workspace.workspaceFolders;
    if (workspaceFolders === undefined) {
        return;
    }
    
    const rootFolder = workspaceFolders[0].uri.fsPath;
    const promptFilePath = path.join(rootFolder, 'prompt.yaml');
    try {
        if (fs.existsSync(promptFilePath)) {
            const currentWindows = vscode.workspace.textDocuments.map(doc => path.relative(rootFolder, doc.fileName));
            const promptFile = yaml.load(fs.readFileSync(promptFilePath, 'utf8'));
            promptFile.attention = currentWindows;
            fs.writeFileSync(promptFilePath, yaml.dump(promptFile), 'utf8');
            vscode.window.showInformationMessage('Prompt file updated successfully!');
        } else {
            vscode.window.showErrorMessage('No prompt.yaml file found in the project root!');
        }
    } catch (error) {
        vscode.window.showErrorMessage('Error updating the prompt.yaml file!');
    }
};

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

src/writeAttention.ts:4:23 - error TS7016: Could not find a declaration file for module &#39;js-yaml&#39;. &#39;/Users/ko/projects-new/Junior/integrations/vscode/node_modules/js-yaml/index.js&#39; implicitly has an &#39;any&#39; type.
Try `npm i --save-dev @types/js-yaml` if it exists or add a new declaration (.d.ts) file containing `declare module &#39;js-yaml&#39;;`
4 import * as yaml from &#39;js-yaml&#39;;
                      ~~~~~~~~~



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files without substitution.
Assume OSX.
npm and jq are installed.
Do NOT write any text outside the script (the plan goes into it)!


EXAMPLE START

```sh
#!/bin/sh
# Goal: [Task description, max 7 words]
# Plan:
# 1. [...]

[Commands solving the task]
```

EXAMPLE END

