#!/bin/sh
set -e
goal="Improve the documentation"
echo "Plan:"
echo "1. Modify docs/README.md to remove warning and improve clarity."
echo "2. Modify README.md to remove warning and improve clarity."

# Step 1: Modify docs/README.md
cat > docs/README.md << 'EOF'
# Junior - Your AI-first IDE 

[![Video: Junior codes itself](/assets/video_cover.jpg)](https://youtu.be/NL4uFJSvfW0)

*"Video: Junior codes itself"*

Junior is an **AI-first IDE** designed specifically for professional programmers who have a preference for customizing and fine-tuning their tools. 

With Junior, developers get a unique space where they can work hand-in-hand with AI throughout the development process. By using structured task descriptors and spotlighting relevant parts of a project, tasks like code implementation, documentation, and testing can be seamlessly delegated to Junior.

At its core, Junior embraces a design philosophy that prioritizes simplicity, configurability, and auditability. This ensures that the platform remains both accessible to its users and adaptable to a variety of use-cases.

Junior has been crafted exclusively with AI-powered coding right from its early days, way before its core functionalities were in place. This demonstrates Junior's pioneering approach to harnessing the potential of artificial intelligence in software development.

## Getting Started

For guidance on using Junior, please refer to [usage.md](usage.md).

## Contributing and Support

Your contributions make a difference! At Junior, we value the collaboration of the community. Your role as a contributor is to monitor the development, provide detailed prompts, and thoroughly review the generated outcomes.

For questions or assistance, please raise an issue in our GitHub repository.

**Note:** We've tested Junior primarily with the GPT-4 model. However, you're welcome to experiment with similarly capable models and share your findings. It's not compatible with GPT-3.5.
EOF

# Step 2: Modify README.md
cat > README.md << 'EOF'
[![Docs: Junior Documentation](https://img.shields.io/badge/docs-Junior-blue)](https://tisztamo.github.io/Junior/#/)

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

Contributions are welcome! Remember, Junior is designed to write itself. Your main role will be to oversee the work, provide detailed prompts, and review the outcomes.

For support, please create an issue in the GitHub repository.

**Note:** For meaningful results, it's recommended to use the GPT-4 model or a more recent version.
EOF

echo "\033[32mDone: $goal\033[0m\n"