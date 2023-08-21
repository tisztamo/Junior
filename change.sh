#!/bin/sh
set -e
goal="Fix TypeScript error for promptFile"
echo "Plan:"
echo "1. Create types.ts to define the PromptFile interface"
echo "2. Update readPromptFile.ts to specify return type"
echo "3. Update writeAttention.ts to use the new interface"

# Step 1: Create types.ts
cat << 'EOF' > integrations/vscode/src/types.ts
export interface PromptFile {
    attention?: string[];
    [key: string]: any;  // Allow additional properties
}
EOF

# Step 2: Update readPromptFile.ts
cat << 'EOF' > integrations/vscode/src/readPromptFile.ts
import * as fs from 'fs';
import * as yaml from 'js-yaml';
import { PromptFile } from './types';

export const readPromptFile = (filePath: string): PromptFile => {
    return yaml.load(fs.readFileSync(filePath, 'utf8')) as PromptFile;
};
EOF

# Step 3: Update writeAttention.ts
cat << 'EOF' > integrations/vscode/src/writeAttention.ts
import * as vscode from 'vscode';
import { getRootWorkspace } from './getRootWorkspace';
import { getPromptFilePath } from './getPromptFilePath';
import { getCurrentOpenDocuments } from './getCurrentOpenDocuments';
import { readPromptFile } from './readPromptFile';
import { writePromptFile } from './writePromptFile';
import { updateAttentionSection } from './updateAttentionSection';
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
            const attentionSection = updateAttentionSection(currentWindows, excludeList, rootFolder);
            const promptFile: PromptFile = readPromptFile(promptFilePath);
            promptFile.attention = attentionSection;
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
