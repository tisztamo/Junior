# Working set

```
docs/assets/
├── favicon.ico
├── logo.png
├── logo.svg
├── video_cover.jpg

```
docs/assets/logo.svg:
```
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
    <rect x="0" y="0" rx="10" ry="10" width="100" height="30" style="fill:blue;" />
    <rect x="0" y="33" rx="10" ry="10" width="100" height="30" style="fill:orange;" />
    <rect x="0" y="66" rx="10" ry="10" width="48" height="34" style="fill:red;" />
    <rect x="52" y="66" rx="10" ry="10" width="48" height="34" style="fill:green;" />
</svg>

```


# Task

Improve the documentation!

Favicon háttere fehér.
Legyen átlátszó!
svg -&gt; png -&gt; ico, convert van.


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

