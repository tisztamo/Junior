#!/bin/sh
set -e
goal="Consolidate file writing logic"
echo "Plan:"
echo "1. Modify writeAttention.ts to only call writePromptFile."
echo "2. Modify writePromptFile.ts to handle both file writing and editor content updating."

# Step 1: Modify writeAttention.ts to only call writePromptFile.
cat > integrations/vscode/src/writeAttention.ts << 'EOF'
import * as vscode from 'vscode';
import * as yaml from 'js-yaml';
import { getRootWorkspace } from './getRootWorkspace';
import { getPromptFilePath } from './getPromptFilePath';
import { getCurrentOpenDocuments } from './getCurrentOpenDocuments';
import { readPromptFile } from './readPromptFile';
import { filterAttentionExcludes } from './filterAttentionExcludes';
import { writePromptFile } from './writePromptFile';
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
            writePromptFile(promptFilePath, promptFile);
        } else {
            vscode.window.showErrorMessage('No prompt.yaml file found in the project root!');
        }
    } catch (error) {
        vscode.window.showErrorMessage('Error updating the prompt.yaml file!');
    }
};
EOF

# Step 2: Modify writePromptFile.ts to handle both file writing and editor content updating.
cat > integrations/vscode/src/writePromptFile.ts << 'EOF'
import * as fs from 'fs';
import * as vscode from 'vscode';
import * as yaml from 'js-yaml';

export const writePromptFile = (filePath: string, data: any) => {
    const openedDocument = vscode.workspace.textDocuments.find(doc => doc.fileName === filePath);
    if (openedDocument) {
        const edit = new vscode.WorkspaceEdit();
        const range = new vscode.Range(new vscode.Position(0, 0), new vscode.Position(openedDocument.lineCount, 0));
        edit.replace(openedDocument.uri, range, yaml.dump(data));
        vscode.workspace.applyEdit(edit);
    } else {
        fs.writeFileSync(filePath, yaml.dump(data), 'utf8');
    }
};
EOF

# We don't have the content of updateEditorContents.ts, but we know it should be deleted.
rm integrations/vscode/src/updateEditorContents.ts

echo "\033[32mDone: $goal\033[0m\n"