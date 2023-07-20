#!/bin/sh
# Goal: Factor out the exclude handling and fix missing type for promptFile
# Plan:
# 1. Create a new file "filterAttentionExcludes.ts" that contains the filtering logic.
# 2. In the new file, export a function that takes an array of window paths, an exclude list, and the root folder path as parameters, and returns a filtered array of window paths.
# 3. In "writeAttention.ts", import the function from "filterAttentionExcludes.ts" and use it in place of the inline filtering logic.
# 4. Declare a type for the promptFile to avoid missing type errors.

# Create filterAttentionExcludes.ts with the new filtering function
cat > integrations/vscode/src/filterAttentionExcludes.ts <<'EOF'
import * as glob from 'glob';
import * as path from 'path';
import * as fs from 'fs';

export const filterAttentionExcludes = (windowPaths, excludeList, rootFolder) => {
    return windowPaths.filter(windowPath => {
        return !windowPath.endsWith('.git') && windowPath !== 'prompt.yaml' && windowPath !== 'prompt.md' && windowPath !== 'change.sh' && !excludeList.some((pattern) => glob.sync(pattern, { cwd: rootFolder }).includes(windowPath)) && fs.existsSync(path.join(rootFolder, windowPath));
    });
}
EOF

# Modify writeAttention.ts to use the new function and declare a type for promptFile
cat > integrations/vscode/src/writeAttention.ts <<'EOF'
import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';
import * as yaml from 'js-yaml';
import { filterAttentionExcludes } from './filterAttentionExcludes';

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
            const filteredWindows = filterAttentionExcludes(currentWindows, excludeList, rootFolder);
            const promptFile: any = yaml.load(fs.readFileSync(promptFilePath, 'utf8'));
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
EOF


#!/bin/sh
# Goal: Add explicit type declarations for function parameters
# Plan:
# 1. For function `filterAttentionExcludes`, explicitly type parameters 'windowPaths', 'excludeList', and 'rootFolder'.
# 2. 'windowPaths' should be an array of strings (string[]), 'excludeList' should be an array of strings (string[]), and 'rootFolder' should be a string.

# Modify filterAttentionExcludes.ts to add explicit types to function parameters
cat > integrations/vscode/src/filterAttentionExcludes.ts <<'EOF'
import * as glob from 'glob';
import * as path from 'path';
import * as fs from 'fs';

export const filterAttentionExcludes = (windowPaths: string[], excludeList: string[], rootFolder: string) => {
    return windowPaths.filter(windowPath => {
        return !windowPath.endsWith('.git') && windowPath !== 'prompt.yaml' && windowPath !== 'prompt.md' && windowPath !== 'change.sh' && !excludeList.some((pattern) => glob.sync(pattern, { cwd: rootFolder }).includes(windowPath)) && fs.existsSync(path.join(rootFolder, windowPath));
    });
}
EOF
