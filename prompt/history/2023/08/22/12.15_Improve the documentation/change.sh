#!/bin/sh
set -e
goal="Improve the documentation"
echo "Plan:"
echo "1. Remove backup files from docs"
echo "2. Remove src/doc/ directory"
echo "3. Update README.md content"
echo "4. Confirm changes"

# 1. Remove backup files from docs
rm docs/README.md.backup
rm docs/_sidebar_backup.md

# 2. Remove src/doc/ directory
rm -rf src/doc/

# 3. Update README.md content
cat > docs/README.md <<'EOF'
Warn: This README is AI generated, just like all the source files of this project.

# Junior - Your AI-first IDE 

[![Video: Junior codes itself](/assets/video_cover.jpg)](https://youtu.be/NL4uFJSvfW0)

*"Video: Junior codes itself"*

Junior is an **AI-first IDE** targeting craftsmen, professional programmers who enjoy customizing and fine-tuning their tools. Embracing a design philosophy of being simple, configurable, and auditable, Junior offers a unique space where developers can work hand-in-hand with AI throughout the development process.

With a structured task descriptor and by spotlighting relevant parts of your project, you can delegate tasks such as code implementation, documentation, testing, and more, to Junior.

## Getting Started

For guidance on using Junior, please refer to [usage.md](usage.md).

## Contributing and Support

Your contributions make a difference! At Junior, we value the collaboration of the community. Your role as a contributor is to monitor the development, provide detailed prompts, and thoroughly review the generated outcomes.

For questions or assistance, please raise an issue in our GitHub repository.

**Note:** We've tested Junior primarily with the GPT-4 model. However, you're welcome to experiment with similarly capable models and share your findings. It's not compatible with GPT-3.5.
EOF

# 4. Confirm changes
echo "\033[32mDone: $goal\033[0m\n"