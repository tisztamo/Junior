#!/bin/sh
# Goal: Implement command for overwriting prompt.yaml 'attention' field
# Plan:
# 1. Eliminate trivial comments from extension.ts
# 2. Create a new file to handle 'writeAttention' command logic
# 3. Implement the logic of the 'writeAttention' command
# 4. Register new 'writeAttention' command in extension.ts
# 5. Add new 'writeAttention' command to package.json

# Step 1: Eliminate trivial comments from extension.ts
cat <<EOF > integrations/vscode/src/extension.ts
import * as vscode from 'vscode';
import { writeAttention } from './writeAttention';

export function activate(context: vscode.ExtensionContext) {
	console.log('Junior extension is now active!');

	let helloWorldDisposable = vscode.commands.registerCommand('junior.helloWorld', () => {
		vscode.window.showInformationMessage('Hello World from Junior!');
	});

	let writeAttentionDisposable = vscode.commands.registerCommand('junior.writeAttention', writeAttention);

	context.subscriptions.push(helloWorldDisposable);
	context.subscriptions.push(writeAttentionDisposable);
}

export function deactivate() {}
EOF

# Step 2: Create a new TypeScript file to handle 'writeAttention' command logic
touch integrations/vscode/src/writeAttention.ts

# Step 3: Implement the logic of the 'writeAttention' command
cat <<EOF > integrations/vscode/src/writeAttention.ts
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
EOF

# Step 4: Register new 'writeAttention' command in extension.ts
cat <<EOF > integrations/vscode/src/extension.ts
import * as vscode from 'vscode';
import { writeAttention } from './writeAttention';

export function activate(context: vscode.ExtensionContext) {
	console.log('Junior extension is now active!');

	let helloWorldDisposable = vscode.commands.registerCommand('junior.helloWorld', () => {
		vscode.window.showInformationMessage('Hello World from Junior!');
	});

	let writeAttentionDisposable = vscode.commands.registerCommand('junior.writeAttention', writeAttention);

	context.subscriptions.push(helloWorldDisposable);
	context.subscriptions.push(writeAttentionDisposable);
}

export function deactivate() {}
EOF

# Step 5: Add new 'writeAttention' command to package.json
jq '.contributes.commands[1]={"command": "junior.writeAttention","title": "Write Attention"}' integrations/vscode/package.json > temp.json && mv temp.json integrations/vscode/package.json

# Navigate to the vscode subfolder to execute further commands
cd integrations/vscode

# Install js-yaml dependency
npm install --save js-yaml

# Re-run the compilation and packaging process for the extension
npm run vscode:prepublish

# Navigate back to the original project directory
cd ../..
