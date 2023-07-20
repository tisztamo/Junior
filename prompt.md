# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── README.md
├── babel.config.js
├── change.sh
├── doc/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...

```
```
integrations/vscode/
├── .eslintrc.json
├── .gitignore
├── .vscode/...
├── .vscodeignore
├── CHANGELOG.md
├── README.md
├── junior-0.0.1.vsix
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
        "command": "junior.writeAttention",
        "title": "Write Attention"
      }
    ],
    "configuration": {
      "type": "object",
      "title": "Junior",
      "properties": {
        "junior.attentionExcludeList": {
          "type": "array",
          "default": [],
          "description": "List of file patterns to exclude from attention"
        }
      }
    }
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


# Task

Fix the following issue!

We need to move glob and its types from devdeps to deps in order for vsce to package it.


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

