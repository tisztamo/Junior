#!/bin/sh
set -e
goal="Update and save using VSCode API"
echo "Plan:"
echo "1. Revise writePromptFile.ts to save the document unconditionally."

# Step 1: Modify writePromptFile.ts to save the document unconditionally.
cat > integrations/vscode/src/writePromptFile.ts << 'EOF'
import * as vscode from 'vscode';
import * as yaml from 'js-yaml';

export const writePromptFile = async (filePath: string, data: any) => {
    let openedDocument = vscode.workspace.textDocuments.find(doc => doc.fileName === filePath);
    if (!openedDocument) {
        openedDocument = await vscode.workspace.openTextDocument(filePath);
    }
    
    const edit = new vscode.WorkspaceEdit();
    const range = new vscode.Range(new vscode.Position(0, 0), new vscode.Position(openedDocument.lineCount, 0));
    edit.replace(openedDocument.uri, range, yaml.dump(data));
    await vscode.workspace.applyEdit(edit);
    
    // Save the document unconditionally.
    openedDocument.save();
};
EOF

echo "\033[32mDone: $goal\033[0m\n"