# Working set

```
./
├── .DS_Store
├── .git/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── change.sh
├── dist/...
├── doc/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── secret.sh
├── src/...
├── tmp/...

```
./README.md:
```
# The Contributor - Your AI contributor which writes itself.

## Description

The goal of this exploratory project is to allow programmers to communicate solely with the AI and merely supervise the development process. This is much like how Linus Thorwalds, the creator of Linux Kernel, supervises its development without having to write code himself.

## Getting Started

### The Prompt Descriptor

A prompt descriptor (prompt.yaml) provides details necessary to generate a prompt for the AI model.

For instance, here is an example of a prompt descriptor:

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

### Attention Mechanism

The attention mechanism provides the AI model with a working set, a subset of the entire project that's currently in focus. It includes both files and directories.

For files, the content is directly provided to the AI. For directories, a list of files and subdirectories within them is presented. Directories are denoted with a trailing `/`.

## Contributing and Support

Contributions are welcome, but remember, this project writes itself!

```


# Task

Improve the documentation!

Include the provided new information (if any).

# Output Format

Provide the new or modified file(s) as code blocks, each prefixed with its path and a colon.
JS files should only export a single function and be named after the function: e.g. `myFn.js` should export `myFn()`.
Always output full files, copying unchanged content.

E.g.:

texts/sample.txt:
```
A sample text file.
```


