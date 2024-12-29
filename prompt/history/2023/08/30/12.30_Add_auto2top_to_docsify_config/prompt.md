You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

docs/docsifyConfig.js:
```
window.$docsify = {
  name: 'Junior',
  repo: 'https://github.com/tisztamo/Junior',
  loadSidebar: true,
  autoHeader: true,
  logo: "assets/logo.svg",
  nameLink: 'https://github.com/tisztamo/Junior',
  coverpage: true
}

```


# Task

Improve the documentation!

Add auto2top: true to docsify config

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

