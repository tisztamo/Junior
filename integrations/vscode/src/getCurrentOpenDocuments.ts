import * as vscode from 'vscode';
import * as path from 'path';

export const getCurrentOpenDocuments = (rootFolder: string) => {
    return vscode.workspace.textDocuments.map(doc => path.relative(rootFolder, doc.fileName));
};
