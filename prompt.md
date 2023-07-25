# Working set

```
./
├── .DS_Store
├── .git/...
├── .github/...
├── .gitignore
├── .vscode/...
├── README.md
├── babel.config.js
├── change.sh
├── doc/...
├── integrations/...
├── node_modules/...
├── package-lock.json
├── package.json
├── postcss.config.cjs
├── prompt/...
├── prompt.md
├── prompt.yaml
├── src/...
├── tailwind.config.js

```
```
src/
├── .DS_Store
├── attention/...
├── backend/...
├── config.js
├── doc/...
├── execute/...
├── frontend/...
├── git/...
├── index.html
├── interactiveSession/...
├── llm/...
├── main.js
├── prompt/...
├── startVite.js
├── vite.config.js
├── web.js

```
```
src/frontend/
├── App.jsx
├── components/...
├── fetchTasks.js
├── generatePrompt.js
├── getBaseUrl.js
├── index.jsx
├── service/...
├── stores/...
├── styles/...

```
postcss.config.cjs:
```
const tailwindcss = require('tailwindcss');
const autoprefixer = require('autoprefixer');
const postcssImport = require('postcss-import');
const postcssNested = require('postcss-nested');

module.exports = {
  plugins: {
    'postcss-import': {},
    'tailwindcss/nesting': postcssNested,
    tailwindcss: tailwindcss,
    autoprefixer: autoprefixer,
  },
};

```

src/vite.config.js:
```
import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'

export default defineConfig({
  plugins: [solidPlugin()],
  build: {
    target: 'esnext',
  },
})

```


# Task

Move the following files to the specified target dirs!

Find out the best target dir if it is not specified!

You need to follow dependencies to maintain coherence.

Before executing, write a concise plan! The plan should show:
 - How do you avoid breaking other parts of the code.
 - If you had to choose, your way of thinking.

Move the postcss config to src/frontend/ and configure vite to use it.
In vite docs:
css.postcss# Type: string | (postcss.ProcessOptions &amp; { plugins?: postcss.Plugin[] })
Inline PostCSS config or a custom directory to search PostCSS config from (default is project root).
For inline PostCSS config, it expects the same format as postcss.config.js. But for plugins property, only array format can be used.
The search is done using postcss-load-config and only the supported config file names are loaded.


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

