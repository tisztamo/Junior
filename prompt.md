You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

docs/README.md:
```
Warn: This README is AI generated, just like all the source files of this project.

# Junior - Your AI contributor which codes itself.

[![Video: Junior codes itself](/assets/video_cover.jpg)](https://youtu.be/NL4uFJSvfW0)

*"Video: Junior codes itself"*
## Description

Junior is an AI-first IDE designed from the ground up to leverage language models. This project allows developers to communicate with the AI and supervise the development process.

Isn't that already possible with ChatGPT? No, LLMs have very limited "working memory", so it is not possible to directly work with them on large codebases.

By providing specific task details in a prompt descriptor and highlighting the relevant parts of your project, you can delegate code implementation, documentation, testing, and more to your AI Junior.

## Getting Started

For more details on getting started, please refer to [usage.md](usage.md).

## Contributing and Support

Contributions are welcome! Remember, we eat our own dog food in this project. Junior is designed to write itself. Your main role will be to oversee the work, provide detailed prompts, and review the outcomes.

For support, please create an issue in the GitHub repository.

**Note:** For meaningful results, it's recommended to use the GPT-4 model or a more recent version.

```

README.md:
```
[![Docs: Junior Documentation](https://img.shields.io/badge/docs-Junior-blue)](https://tisztamo.github.io/Junior/#/)
Warn: This README is AI generated, just like all the source files of this project.

# Junior - Your AI contributor which codes itself.

[![Video: Junior codes itself](docs/assets/video_cover.jpg)](https://youtu.be/NL4uFJSvfW0)

*"Video: Junior codes itself"*

## Description

Junior is an AI-first IDE designed from the ground up to leverage language models. Just like how Linus Torvalds oversees the Linux Kernel development without coding himself, this project allows developers to communicate with the AI and supervise the development process.

By providing specific task details in a prompt descriptor and highlighting the relevant parts of your project, you can delegate code implementation, documentation, testing, and more to your AI Junior.

## Getting Started

### Installation

To install, clone the repository and run `npm install` in the root directory. Additionally, you can install the "Junior" vscode extension from the vscode extension marketplace.

### Usage

#### Web Interface

Run the application with `npm start` to start a local server, where you can generate a prompt and automatically copy it to paste into ChatGPT. The web interface is designed for use with ChatGPT Pro and doesn't require an API key. For more information about the web interface, please refer to [docs/web.md](docs/web.md).

#### Command-line interface (CLI)

To start the CLI, use `npm run cli`. This mode uses the ChatGPT API, and you'll need an API key stored in the `OPENAI_API_KEY` environment variable.

### The Prompt Descriptor

A prompt descriptor is a YAML file (`prompt.yaml`) outlining the details necessary for generating a task prompt for the AI model.

Each element in the descriptor serves a specific purpose:
- `task`: Describes the task type and scope. For example, `feature/implement`, `bug/fix`, or `refactor/`. You can check out the [prompt/task/feature/implement.md](prompt/task/feature/implement.md) file as an example.
- `attention`: Lists the files and directories most relevant to the task.
- `requirements`: Describes the actual task in a human-readable format.
- `format`: Determines how the output will be formatted.

### Attention Mechanism

The attention mechanism guides the AI model by providing it with a working set. It helps overcome the limited working memory of large language models.

The working set is a subset of the entire project that's currently in focus. It includes both files and directories. For files, the content is directly provided to the AI. For directories, a brief list of files and subdirectories within them is presented.

## Contributing and Support

Contributions are welcome! Remember, we eat our own dog food in this project. Junior is designed to write itself. Your main role will be to oversee the work, provide detailed prompts, and review the outcomes.

For support, please create an issue in the GitHub repository.

**Note:** For meaningful results, it's recommended to use the GPT-4 model or a more recent version.

```


# Task

Improve the documentation!

Edit only the one in docs/!
Make &#34;AI-first IDE&#34; very visible.
Remove &#34;Description&#34;, but not the content under it.
There is some info about Linus in the other readme, mention it!
Write a sentence about Junior being built for craftmanship:
Junior is configurable, hackable, simple and auditable.
It also has a vision: To becoming something like git is now or something LISP was back then.
Mention joyfully that git is also created by Linus, or what paul Graham wrote about LISP being important in their succees by allowing rapid development.


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

