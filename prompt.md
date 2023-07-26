# Working set

src/frontend/vite.config.js:
```
import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'

export default defineConfig({
  plugins: [solidPlugin()],
  css: {
    postcss: './src/frontend/postcss.config.cjs'
  },
  build: {
    target: 'esnext',
  },
})

```


# Task

Fix the following issue!

The postcss config path should be relative to the vite config file, not the working dir. Use dirname, they are in the same dir

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

