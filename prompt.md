# Working set

docs/docsifyConfig.js:
```
window.$docsify = {
  name: 'Junior',
  repo: 'https://github.com/tisztamo/Junior',
  loadSidebar: true
}
```


# Task

Improve the documentation!

Add the following configs:
- autoHeader: true
- logo: &#34;assets/logo.svg&#34;
- nameLink: Use the repo url


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

