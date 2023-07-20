# Working set

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

postcss.config.js:
```
import tailwindcss from 'tailwindcss';
import autoprefixer from 'autoprefixer';

export default function postCssConfig() {
  return {
    plugins: [
      tailwindcss(),
      autoprefixer()
    ]
  }
}

```


# Task

Fix the following issue!

warn - The `content` option in your Tailwind CSS configuration is missing or empty. warn - Configure your content sources or your generated CSS will be missing styles. warn - https://tailwindcss.com/docs/content-configuration


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files without substitution.
Assume OSX.
npm and jq are installed.
Do NOT write any text outside the script (the plan goes into it)!


EXAMPLE START

```sh
#!/bin/sh
# Goal: [Task description, max 7 words]
# Plan:
# 1. [...]

[Commands solving the task]
```

EXAMPLE END

