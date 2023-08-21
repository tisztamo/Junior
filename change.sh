#!/bin/sh
set -e
goal="Preserve directory entries in attention"
echo "Plan:"
echo "1. Modify the 'writeAttention' function to preserve directory entries in the attention section."
echo "2. Extract the logic of preserving directory entries into a new helper function named 'updateAttention' in a file named 'updateAttention.ts'."

# Step 1: Extract the logic of preserving directory entries into a new helper function named 'updateAttention'.
cat << 'EOF' > integrations/vscode/src/updateAttention.ts
import { PromptFile } from './types';

export const updateAttention = (currentAttention: string[] | undefined, newAttention: string[]): string[] => {
    // If there's no current attention section, just return the new attention.
    if (!currentAttention) {
        return newAttention;
    }

    // Filter out directories from the current attention.
    const currentDirectories = currentAttention.filter(item => item.endsWith('/'));

    // Add the current directories to the new attention list.
    return [...new Set([...currentDirectories, ...newAttention])];
};
EOF

# Step 2: Modify the 'writeAttention' function to use the new helper function 'updateAttention'.
cat << 'EOF' > integrations/vscode/src/writeAttention.ts
import * as vscode from 'vscode';
import { getRootWorkspace } from './getRootWorkspace';
import { getPromptFilePath } from './getPromptFilePath';
import { getCurrentOpenDocuments } from './getCurrentOpenDocuments';
import { readPromptFile } from './readPromptFile';
import { filterAttentionExcludes } from './filterAttentionExcludes';
import { writePromptFile } from './writePromptFile';
import { updateAttention } from './updateAttention';
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
            promptFile.attention = updateAttention(promptFile.attention, attentionSection);
            writePromptFile(promptFilePath, promptFile);
        } else {
            vscode.window.showErrorMessage('No prompt.yaml file found in the project root!');
        }
    } catch (error) {
        vscode.window.showErrorMessage('Error updating the prompt.yaml file!');
    }
};
EOF

echo "\033[32mDone: $goal\033[0m\n"