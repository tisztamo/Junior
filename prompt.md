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
./src/
├── .DS_Store
├── attention/...
├── backend/...
├── config.js
├── doc/...
├── execute/...
├── frontend/...
├── git/...
├── interactiveSession/...
├── llm/...
├── main.js
├── prompt/...
├── web.js

```
```
./src/frontend/
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
src/frontend/postcss.config.cjs:
```
const tailwindcss = require('tailwindcss');
const autoprefixer = require('autoprefixer');
const postcssImport = require('postcss-import');
const postcssNested = require('postcss-nested');

module.exports = {
  plugins: {
    'postcss-import': {},
    'tailwindcss/nesting': postcssNested,
    tailwindcss: { config: './src/frontend/tailwind.config.cjs' },
    autoprefixer: autoprefixer,
  },
};

```


# Task

Fix the following issue!

The tailwind config path should be relative to the postcss config file, not the working dir. Also remove unused imports!

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

