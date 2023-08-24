You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

docs/roadmap.md:
```
# Roadmap

## Usability & fixes
v0.2 (Released: Aug 2023)
- ✅ Done: Implement the four buttons
- ✅ Done: Fix every major bug
- ✅ Done: Write docs to allow using Junior for developing external projects

## Programming on mobile
v0.3 (Expected: Q4 2023)
- Develop a file browser to allow the user to select attention files from mobile
- Allow secure hosting
- Create an app by wrapping the frontend
- Test it by developing at the local Playground and while commuting

## Plugin system
v0.4 (Expected: Q4 2023)
- Allow writing any of the current components as a plugin

## Auto-attention
v0.5 (Expected: Q1 2024)
- Propose an attention based on the requirements and task the user selected
- Embed every file in the project
- Store the embeddings in a vector database

## Prompt herds
v0.6 (Expected: Q2 2024)
- Scan and transform (refactor) the codebase gradually

```


# Task

Improve the documentation!

Make the lines with versions and dates monospace. Mark the file browser item with a unicode char as under construction

Do not create backup files.

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

