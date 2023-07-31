# Working set

.github/ISSUE_TEMPLATE/freely-interpreted-issue.md:
```
---
name: Freely interpreted issue
about: What it says
title: ''
labels: ''
assignees: ''

---

## Project Description

Hey, Contributor!

Interpret issues freely. Need help or have ideas? Comment right here. Remember, this is the only forum where Krisztián answers questions - your golden ticket to help!

Keep it friendly, that's our vibe.

Happy contributing!

```


# Task

Improve the documentation!

Add a note to the issue template that we eat our own dog food:
use Junior to work on Junior and commit prompt.yaml, prompt.md and change.sh


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.

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

