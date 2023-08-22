#!/bin/sh
set -e
goal="Improve Junior documentation"
echo "Plan:"
echo "1. Update the README.md file by splitting the section under the video into 4-5 paragraphs, with target group improvements and the note about Junior's inception."

cat > docs/README.md << 'EOF'
Warn: This README is AI generated, just like all the source files of this project.

# Junior - Your AI-first IDE 

[![Video: Junior codes itself](/assets/video_cover.jpg)](https://youtu.be/NL4uFJSvfW0)

*"Video: Junior codes itself"*

Junior is an **AI-first IDE** designed specifically for professional programmers who have a penchant for customizing and fine-tuning their tools. 

In a bold move, Junior has been crafted exclusively with AI-powered coding right from its early days, way before its core functionalities were in place. This demonstrates Junior's pioneering approach to harnessing the potential of artificial intelligence in software development.

At its core, Junior embraces a design philosophy that prioritizes simplicity, configurability, and auditability. This ensures that the platform remains both accessible to its users and adaptable to a variety of use-cases.

With Junior, developers get a unique space where they can work hand-in-hand with AI throughout the development process. By using structured task descriptors and spotlighting relevant parts of a project, tasks like code implementation, documentation, and testing can be seamlessly delegated to Junior.

## Getting Started

For guidance on using Junior, please refer to [usage.md](usage.md).

## Contributing and Support

Your contributions make a difference! At Junior, we value the collaboration of the community. Your role as a contributor is to monitor the development, provide detailed prompts, and thoroughly review the generated outcomes.

For questions or assistance, please raise an issue in our GitHub repository.

**Note:** We've tested Junior primarily with the GPT-4 model. However, you're welcome to experiment with similarly capable models and share your findings. It's not compatible with GPT-3.5.

EOF

echo "\033[32mDone: $goal\033[0m\n"