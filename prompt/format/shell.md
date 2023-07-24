Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.
OS: <%= os %>
Installed tools: <%= installedTools %>
Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
# Plan:
# 1. [...]
# ...
# N. echo "Completed: $goal\n"

[Commands solving the task]
```

EXAMPLE END