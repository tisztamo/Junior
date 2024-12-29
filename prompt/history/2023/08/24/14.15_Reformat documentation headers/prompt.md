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
- ✅ Done: Implement the four buttons
- ✅ Done: Fix every major bug
- ✅ Done: Write docs to allow using Junior for developing external projects

## Programming on mobile
- Develop a file browser to allow the user to select attention files from mobile
- Create an app by wrapping the frontend
- Test it by developing at the local Playground and while commuting

## Auto-attention
- Propose an attention based on the requirements and task the user selected
- Embed every file in the project
- Store the embeddings in an (embedded) vector database

## Prompt herds
- Scan and transform (refactor) the codebase gradually

```


# Task

Improve the documentation!

Incorporate version numbers:
  "Usability & fixes" is 0.2, released aug 2023
  "Programming on mobile" will be 0.3, q4 2023
    Add a new subitem as the second one: "Allow secure hosting" 
  Add a new item "Plugin system" 0.4 q4 2023
    Allow writing any of the current components as a plugin
  "Auto-attention" 0.5 q1 2024
    Remove "(embedded)"
  "Prompt herds" 0.6 q2 2024


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

