#!/bin/sh
set -e
goal="Update README.md as per requirements"
echo "Plan:"
echo "1. Update image URL to /assets/video_cover.jpg"
echo "2. Remove details in section '### The Prompt Descriptor' and replace with a sentence linking to descriptor.md"

# Command to change the image URL
cat > docs/README.md << 'EOF'
Warn: This README is AI generated, just like all the source files of this project.

# Junior - Your AI contributor which codes itself.

[![Video: Junior codes itself](/assets/video_cover.jpg)](https://www.youtube.com/watch?v=W_iwry8uT7E)

*"Video: Junior codes itself"*
## Description

Junior is an exploratory project aimed at revolutionizing the way programmers interact with the development process. Just like how Linus Torvalds oversees the Linux Kernel development without coding himself, this project allows developers to communicate with the AI and supervise the development process.

Isn't that already possible with ChatGPT? No, LLMs have very limited "working memory", so it is not possible to directly work with them on large codebases.

By providing specific task details in a prompt descriptor and highlighting the relevant parts of your project, you can delegate code implementation, documentation, testing, and more to your AI Junior.

## Getting Started

### Installation

To install, clone the repository and run `npm install` in the root directory. Additionally, you can install the "Junior" vscode extension from the vscode extension marketplace.

### Usage

#### Web Interface

Run the application with `npm start` to start a local server, where you can generate a prompt and automatically copy it to paste into ChatGPT. The web interface is designed for use with ChatGPT Pro and doesn't require an API key. For more information about the web interface, please refer to [doc/web.md](doc/web.md).

#### Command-line interface (CLI)

To start the CLI, use `npm run cli`. This mode uses the ChatGPT API, and you'll need an API key stored in the `OPENAI_API_KEY` environment variable.

### The Prompt Descriptor

The prompt descriptor is a YAML file that outlines the details necessary for generating a task prompt for the AI model. For more details, refer to [descriptor.md](descriptor.md).

### Attention Mechanism

The attention mechanism guides the AI model by providing it with a working set. It helps overcome the limited working memory of large language models.

The working set is a subset of the entire project that's currently in focus. It includes both files and directories. For files, the content is directly provided to the AI. For directories, a brief list of files and subdirectories within them is presented.

## Contributing and Support

Contributions are welcome! Remember, we eat our own dog food in this project. Junior is designed to write itself. Your main role will be to oversee the work, provide detailed prompts, and review the outcomes.

For support, please create an issue in the GitHub repository.

**Note:** For meaningful results, it's recommended to use the GPT-4 model or a more recent version.

EOF

echo "\033[32mDone: $goal\033[0m\n"
