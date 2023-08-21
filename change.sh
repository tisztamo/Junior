#!/bin/sh
set -e
goal="Integrate editor contents for prompt.yaml"
echo "Plan:"
echo "1. Refactor readPromptFile.ts to prioritize the editor content if prompt.yaml is open in the editor."
echo "2. If the file is not open, it will read from the file as it used to."
echo "3. Update the writeAttention.ts to use the new readPromptFile method."

# Step 1: Refactor readPromptFile.ts
cat > integrations/vscode/src/readPromptFile.ts <<EOF
import * as fs from 'fs';
import * as vscode from 'vscode';
import * as yaml from 'js-yaml';
import { PromptFile } from './types';

export const readPromptFile = async (filePath: string): Promise<PromptFile> => {
    const openedDocument = vscode.workspace.textDocuments.find(doc => doc.fileName === filePath);
    if (openedDocument) {
        return yaml.load(openedDocument.getText()) as PromptFile;
    }
    return yaml.load(fs.readFileSync(filePath, 'utf8')) as PromptFile;
};
EOF

# Step 2: Update the writeAttention.ts file to use the new async readPromptFile method.
cat > integrations/vscode/src/writeAttention.ts <<EOF
import * as vscode from 'vscode';
import * as yaml from 'js-yaml';
import { getRootWorkspace } from './getRootWorkspace';
import { getPromptFilePath } from './getPromptFilePath';
import { getCurrentOpenDocuments } from './getCurrentOpenDocuments';
import { readPromptFile } from './readPromptFile';
import { writePromptFile } from './writePromptFile';
import { filterAttentionExcludes } from './filterAttentionExcludes';
import { updateEditorContents } from './updateEditorContents';
import { PromptFile } from './types';

export const writeAttention = async () => {
    const rootFolder = getRootWorkspace();
    if (!rootFolder) {
        return;
    }

    const promptFilePath = getPromptFilePath(rootFolder);
    const excludeList = vscode.workspace.getConfiguration('junior').get('attentionExcludeList', []);
    try {
        if (promptFilePath) {
            const currentWindows = getCurrentOpenDocuments(rootFolder);
            
            const attentionSection = filterAttentionExcludes(currentWindows, excludeList, rootFolder);
            
            const promptFile: PromptFile = await readPromptFile(promptFilePath);
            promptFile.attention = attentionSection;
            
            const newContents = yaml.dump(promptFile);
            await updateEditorContents(promptFilePath, newContents);
            
            writePromptFile(promptFilePath, promptFile);
            
            vscode.window.showInformationMessage('Prompt file updated successfully!');
        } else {
            vscode.window.showErrorMessage('No prompt.yaml file found in the project root!');
        }
    } catch (error) {
        vscode.window.showErrorMessage('Error updating the prompt.yaml file!');
    }
};
EOF

echo "\033[32mDone: $goal\033[0m\n"