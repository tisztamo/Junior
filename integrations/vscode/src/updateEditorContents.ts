import * as vscode from 'vscode';

export const updateEditorContents = async (filePath: string, data: any) => {
    const document = await vscode.workspace.openTextDocument(filePath);
    const editor = await vscode.window.showTextDocument(document);
    await editor.edit(editBuilder => {
        editBuilder.replace(new vscode.Range(document.lineAt(0).range.start, document.lineAt(document.lineCount - 1).range.end), data);
    });
};
