# Working set

```
integrations/vscode/
├── .eslintrc.json
├── .gitignore
├── .vscode/...
├── .vscodeignore
├── CHANGELOG.md
├── LICENSE.txt
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
        "title": "Junior: Write Attention"
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
    "@types/mocha": "^10.0.1",
    "@types/node": "20.2.5",
    "@types/vscode": "^1.80.0",
    "@typescript-eslint/eslint-plugin": "^5.59.8",
    "@typescript-eslint/parser": "^5.59.8",
    "@vscode/test-electron": "^2.3.2",
    "eslint": "^8.41.0",
    "mocha": "^10.2.0",
    "typescript": "^5.1.3"
  },
  "dependencies": {
    "js-yaml": "^4.1.0",
    "glob": "^8.1.0",
    "@types/glob": "^8.1.0"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/tisztamo/Junior.git"
  }
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Set JuniorOpenSourceProject as the publisher



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.

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

