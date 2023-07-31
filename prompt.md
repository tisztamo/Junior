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
├── doc/...
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
doc/assets/
├── video_cover.jpg

```
```
src/frontend/
├── App.jsx
├── components/...
├── fetchTasks.js
├── generatePrompt.js
├── getBaseUrl.js
├── index.html
├── index.jsx
├── postcss.config.cjs
├── service/...
├── startVite.js
├── stores/...
├── styles/...
├── tailwind.config.cjs
├── vite.config.js

```
src/frontend/index.html:
```
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>Junior</title>
</head>
<body>
  <div id="app"></div>
  <script type="module" src="/index.jsx"></script>
</body>
</html>

```


# Task

Improve the documentation!

Generate a logo to doc/assets/logo.png The logo is 1:1 consists of 4 rounded rectangles stacked on each other with small gaps inbetween. Colors from up to down: rgb(59, 130, 246), rgb(253, 186, 116), rgb(185, 28, 28) and rgb(28, 185, 28) generate a favicon to src/frontend/assets/ (Create directory) Use the favicon in index.html convert is installed


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

