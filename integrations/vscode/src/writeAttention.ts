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
