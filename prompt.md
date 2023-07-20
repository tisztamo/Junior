# Working set

integrations/vscode/src/writeAttention.ts:
```
import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';
import * as yaml from 'js-yaml';
import * as glob from 'glob';

export const writeAttention = async () => {
    const workspaceFolders = vscode.workspace.workspaceFolders;
    if (workspaceFolders === undefined) {
        return;
    }
    
    const rootFolder = workspaceFolders[0].uri.fsPath;
    const promptFilePath = path.join(rootFolder, 'prompt.yaml');
    const excludeList = vscode.workspace.getConfiguration('junior').get('attentionExcludeList', []);
    try {
        if (fs.existsSync(promptFilePath)) {
            const currentWindows = vscode.workspace.textDocuments.map(doc => path.relative(rootFolder, doc.fileName));
            const filteredWindows = currentWindows.filter(windowPath => {
                return !windowPath.endsWith('.git') && windowPath !== 'prompt.yaml' && windowPath !== 'prompt.md' && !excludeList.some((pattern: string) => glob.sync(pattern, { cwd: rootFolder }).includes(windowPath)) && fs.existsSync(path.join(rootFolder, windowPath));
            });
            const promptFile = yaml.load(fs.readFileSync(promptFilePath, 'utf8'));
            promptFile.attention = filteredWindows;
            fs.writeFileSync(promptFilePath, yaml.dump(promptFile), 'utf8');
            vscode.window.showInformationMessage('Prompt file updated successfully!');
        } else {
            vscode.window.showErrorMessage('No prompt.yaml file found in the project root!');
        }
    } catch (error) {
        vscode.window.showErrorMessage('Error updating the prompt.yaml file!');
    }
};

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

Also exclude &#34;change.sh&#34;!



# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files without substitution.
Assume OSX.
npm and jq are installed.
Do NOT write any text outside the script (the plan goes into it)!


EXAMPLE START

```sh
#!/bin/sh
# Goal: [Task description, max 7 words]
# Plan:
# 1. [...]

[Commands solving the task]
```

EXAMPLE END

