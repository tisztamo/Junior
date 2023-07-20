# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── README.md
├── babel.config.js
├── change.sh
├── doc/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...

```
```
integrations/vscode/
├── .eslintrc.json
├── .gitignore
├── .vscode/...
├── .vscodeignore
├── CHANGELOG.md
├── README.md
├── node_modules/...
├── out/...
├── package-lock.json
├── package.json
├── src/...
├── tsconfig.json
├── vsc-extension-quickstart.md

```
integrations/vscode/src/writeAttention.ts:
```
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

```

integrations/vscode/src/filterAttentionExcludes.ts:
```
import * as glob from 'glob';
import * as path from 'path';
import * as fs from 'fs';

export const filterAttentionExcludes = (windowPaths: string[], excludeList: string[], rootFolder: string) => {
    return windowPaths.filter(windowPath => {
        return !windowPath.endsWith('.git') && windowPath !== 'prompt.yaml' && windowPath !== 'prompt.md' && windowPath !== 'change.sh' && !excludeList.some((pattern) => glob.sync(pattern, { cwd: rootFolder }).includes(windowPath)) && fs.existsSync(path.join(rootFolder, windowPath));
    });
}

```

README.md:
```
Warn: This README is AI generated, just like all the source files of this project.

# The Junior - Your AI contributor which writes itself.

## Description

The Contributor is an exploratory project aimed at revolutionizing the way programmers interact with the development process. Just like how Linus Torvalds oversees the Linux Kernel development without coding himself, this project allows developers to communicate with the AI and supervise the development process.

By providing specific task details in a prompt descriptor and highlighting the relevant parts of your project, you can delegate code implementation, documentation, testing, and more to your AI Contributor.

## Getting Started

### Installation

To install, clone the repository and run `npm install` in the root directory.

### Usage

There are two ways to use this project: a command-line interface (CLI) and a web interface.

#### Command-line interface (CLI)

To start the CLI, use `npm run cli`. This mode uses the ChatGPT API, and you'll need an API key stored in the `OPENAI_API_KEY` environment variable.

#### Web Interface

Run the application with `npm start` to start a local server on port 3000, where you can generate a prompt and automatically copy it to paste into ChatGPT. The web interface is designed for use with ChatGPT Pro and doesn't require an API key.

### The Prompt Descriptor

A prompt descriptor is a YAML file (`prompt.yaml`) outlining the details necessary for generating a task prompt for the AI model.

Here's an example of a prompt descriptor:

```yaml
task: prompt/task/feature/implement.md
attention:
  - src/interactiveSession/startInteractiveSession.js
  - src/prompt/createPrompt.js
  - src/attention/readAttention.js
  - prompt.yaml
requirements: >
  Write a README.md for this _exploratory_ project!
format: prompt/format/new_file_version.md
```

Each element in the descriptor serves a specific purpose:
- `task`: Describes the task type and scope. For example, `feature/implement`, `bug/fix`, or `refactor/`. You can check out the [prompt/task/feature/implement.md](prompt/task/feature/implement.md) file as an example.
- `attention`: Lists the files and directories most relevant to the task.
- `requirements`: Describes the actual task in a human-readable format.
- `format`: Determines how the output will be formatted.

### Attention Mechanism

The attention mechanism guides the AI model by providing it with a working set. It helps overcome the limited working memory of large language models.

The working set is a subset of the entire project that's currently in focus. It includes both files and directories. For files, the content is directly provided to the AI. For directories, a brief list of files and subdirectories within them is presented.

## Contributing and Support

Contributions are welcome! Remember, we eat our own dog food in this project. This project is designed to write itself. Your main role will be to oversee the work, provide detailed prompts, and review the outcomes.

For support, please create an issue in the GitHub repository.

**Note:** For meaningful results, it's recommended to use the GPT-4 model or a more recent version.
```


# Task

Improve the documentation!

We need a readme for the vscode extension, which is part of the Junior project. Write it to be catchy and to include relevant info about the project (based on the project readme).
Mention that the extension and its doc was fully generated by ChatGPT!
Features: 
  - The &#34;Write Attention&#34; junior.writeAttention command overwrites the attention descriptor based on the currently opened windows in vscode.
  - configuration is possible (extract relevant info from the code)


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

