#!/bin/sh
set -e
goal="Improve documentation in docs/README.md"
echo "Plan:"
echo "1. Backup docs/README.md for safety."
echo "2. Edit docs/README.md with improved content."
echo "3. Save changes."

# Backup the file
cp docs/README.md docs/README.md.backup

# Editing the file
cat > docs/README.md << 'EOF'
Warn: This README is AI generated, just like all the source files of this project.

# Junior - Your AI-first IDE 

[![Video: Junior codes itself](/assets/video_cover.jpg)](https://youtu.be/NL4uFJSvfW0)

*"Video: Junior codes itself"*

Junior is an innovative **AI-first IDE** built to harness the full power of language models. With a setup reminiscent of how Linus Torvalds oversees the Linux Kernel development without writing the code himself, Junior offers a space for developers to communicate directly with AI and actively supervise the entire development process.

Guided by the spirit of craftsmanship, Junior is not only configurable and hackable but also simple and auditable. Our vision is to propel Junior into the same league as iconic tools such as git - another masterpiece by Linus, and the legendary LISP, a language revered by Paul Graham for its significance in enabling rapid development.

By offering specific task details through a prompt descriptor and spotlighting pertinent parts of your project, you can entrust tasks like code implementation, documentation, testing, and more, all to your AI Junior.

## Getting Started

For more insights on getting started, kindly refer to [usage.md](usage.md).

## Contributing and Support

Your contributions are invaluable! Bear in mind, we practice what we preach here. Junior is engineered to be self-reliant. As a contributor, your primary task will be to monitor the proceedings, provide comprehensive prompts, and rigorously review the outcomes.

For assistance, feel free to raise an issue in our GitHub repository.

**Note:** To experience the best results, it's advised to utilize the GPT-4 model or its latest successors.

EOF

echo "\033[32mDone: $goal\033[0m\n"
