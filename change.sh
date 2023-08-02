#!/bin/sh
set -e
goal="Improve documentation for Junior VSCode Extension"
echo "Plan:"
echo "1. Rename the write attention command in package.json"
echo "2. Add the repository field in package.json"
echo "3. Download the GPLv3 license to integrations/vscode/LICENSE.txt"

# Step 1: Rename the write attention command
echo "Renaming the write attention command..."
cat > integrations/vscode/package.json << 'EOF'
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
EOF

# Step 2: Add the repository field
echo "Adding the repository field to package.json..."
jq '.repository = {"type":"git", "url": "git+https://github.com/tisztamo/Junior.git"}' integrations/vscode/package.json > tmp.json && mv tmp.json integrations/vscode/package.json

# Step 3: Download the GPLv3 license
echo "Downloading the GPLv3 license..."
curl -o integrations/vscode/LICENSE.txt https://www.gnu.org/licenses/gpl-3.0.txt

echo "\033[32mDone: $goal\033[0m\n"
