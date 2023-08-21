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
