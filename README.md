Warn: This README is AI generated, just like all the source files of this project.

# The Contributor - Your AI contributor which writes itself.

## Description

The Contributor is an exploratory project aimed at revolutionizing the way programmers interact with the development process. Much like how Linus Thorwalds, the creator of the Linux Kernel, supervises its development without having to write code himself, this project allows developers to solely communicate with the AI and supervise the development process.

By detailing the specifics of a task in a prompt descriptor and highlighting the relevant parts of your project, you can delegate the implementation of code, documentation, tests, and more to your AI Contributor.

## Getting Started

### The Prompt Descriptor

A prompt descriptor is a YAML file (`prompt.yaml`) that outlines the necessary details for generating a task prompt for the AI model.

Here is an example of a prompt descriptor:

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
- `task`: Describes the task type and scope. For example, you can check out the [prompt/task/implement.md](prompt/task/implement.md) file as an example.
- `attention`: Lists the files and directories that are most relevant to the task.
- `requirements`: Describes the actual task in a human-readable format.
- `format`: Determines how the output will be formatted. You can refer to the [prompt/format/new_file_version.md](prompt/format/new_file_version.md) file for an example.

### Attention Mechanism

The attention mechanism is an important part of this project. It guides the AI model by providing it with a working set, which helps overcome the limited working memory of large language models.

This working set is a subset of the entire project that's currently in focus. It includes both files and directories.

For files, the content is directly provided to the AI. For directories, a brief list of files and subdirectories within them is presented. Directories are denoted with a trailing `/`.

## Contributing and Support

Contributions are welcome! However, please keep in mind that this project is designed to write itself. Your main role will be to oversee the work, provide detailed prompts, and review the outcomes.

For support, please create an issue in the GitHub repository and the community will help you out.

