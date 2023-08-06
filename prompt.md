# Working set

```
./
├── .DS_Store
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── README.md
├── change.sh
├── docs/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── prompt/...
├── prompt.md
├── prompt.yaml
├── src/...

```
```
./docs/assets/
├── logo.png
├── video_cover.jpg

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create a new 1:1 logo and save it as logo.svg! Then convert to png and overwrite the old one!
The logo consists of three same-height row stacked on each other with some space inbetween.
The first row is filled by a blue rounded rectangle
The second one is filled by an orange rounded rectangle
The last one contains two rounded rectangles: On the left a red one and on the right a green one. The two fill the row fully and there is some space between them
convert is installed



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

