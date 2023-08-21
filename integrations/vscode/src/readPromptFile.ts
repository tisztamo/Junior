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
