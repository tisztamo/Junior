You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

docs/README.md:
```
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

```


# Task

Improve the documentation!

Set target group better: "...targeting professional programmers who enjoy..."
Add a note that Junior is written without manual coding since the very beginnings, well before the four buttons were all implemented. ( Reword this note to be brave but not what Hungarians call pöffeszkedő )


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: Debian


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

