#!/bin/sh
# Goal: Implement attention feature and remove HelloWorld
# Plan:
# 1. Update the 'writeAttention.ts' file to include only existing files in the attention, exclude 'prompt.yaml' and 'prompt.md', and allow an attention exclude list as a configuration.
# 2. Update the 'extension.ts' file to remove the HelloWorld command.
# 3. Update the 'package.json' file to remove the HelloWorld command and add a new configuration for the attention exclude list.

# Step 1: Update 'writeAttention.ts'
cat > integrations/vscode/src/writeAttention.ts << EOF
import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';
import * as yaml from 'js-yaml';
import * as glob from 'glob';

export const writeAttention = async () => {
    const workspaceFolders = vscode.workspace.workspaceFolders;
    if (workspaceFolders === undefined) {
        return;
    }
    
    const rootFolder = workspaceFolders[0].uri.fsPath;
    const promptFilePath = path.join(rootFolder, 'prompt.yaml');
    const excludeList = vscode.workspace.getConfiguration('junior').get('attentionExcludeList', []);
    try {
        if (fs.existsSync(promptFilePath)) {
            const currentWindows = vscode.workspace.textDocuments.map(doc => path.relative(rootFolder, doc.fileName));
            const filteredWindows = currentWindows.filter(windowPath => {
                return !windowPath.endsWith('.git') && windowPath !== 'prompt.yaml' && windowPath !== 'prompt.md' && !excludeList.some((pattern: string) => glob.sync(pattern, { cwd: rootFolder }).includes(windowPath)) && fs.existsSync(path.join(rootFolder, windowPath));
            });
            const promptFile = yaml.load(fs.readFileSync(promptFilePath, 'utf8'));
            promptFile.attention = filteredWindows;
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

# Step 2: Update 'extension.ts'
cat > integrations/vscode/src/extension.ts << EOF
import * as vscode from 'vscode';
import { writeAttention } from './writeAttention';

export function activate(context: vscode.ExtensionContext) {
	console.log('Junior extension is now active!');

	let writeAttentionDisposable = vscode.commands.registerCommand('junior.writeAttention', writeAttention);

	context.subscriptions.push(writeAttentionDisposable);
}

export function deactivate() {}
EOF

# Step 3: Update 'package.json'
jq '.contributes.commands = [.contributes.commands[1]] | .contributes.configuration = { "type": "object", "title": "Junior", "properties": { "junior.attentionExcludeList": { "type": "array", "default": [], "description": "List of file patterns to exclude from attention" } } }' integrations/vscode/package.json > integrations/vscode/package.json.tmp && mv integrations/vscode/package.json.tmp integrations/vscode/package.json
