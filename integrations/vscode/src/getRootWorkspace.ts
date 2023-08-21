import * as vscode from 'vscode';

export const getRootWorkspace = () => {
    const workspaceFolders = vscode.workspace.workspaceFolders;
    if (workspaceFolders === undefined) {
        return;
    }
    return workspaceFolders[0].uri.fsPath;
};
