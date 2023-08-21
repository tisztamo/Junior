You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

integrations/vscode/src/writePromptFile.ts:
```
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

```

integrations/vscode/src/writeAttention.ts:
```
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

```

integrations/vscode/src/types.ts:
```
export interface PromptFile {
    attention?: string[];
    [key: string]: any;  // Allow additional properties
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Also make prompt.yaml the active document after saving


## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx file accordingly!


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

