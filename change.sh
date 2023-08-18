#!/bin/sh
set -e
goal="Update Junior project README details"
echo "Plan:"
echo "1. Update the video link in README.md."
echo "2. Modify the description of Junior in README.md."

cat << 'EOF' > docs/README.md
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
EOF

echo "\033[32mDone: $goal\033[0m\n"
