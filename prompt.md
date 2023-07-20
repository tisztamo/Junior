# Working set

tailwind.config.js:
```
export default {
  content: ['./src/**/*.html', './src/**/*.js', './src/**/*.jsx', './src/**/*.tsx', './src/**/*.ts'],
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [],
}

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

postcss.config.js:
```
import tailwindcss from 'tailwindcss';
import autoprefixer from 'autoprefixer';
import postcssNested from 'postcss-nested';

export default function postCssConfig() {
  return {
    plugins: [
      postcssNested(),
      tailwindcss(),
      autoprefixer()
    ]
  }
}

```


# Task

Fix the following issue!

[vite:css] Nested CSS was detected, but CSS nesting has not been configured correctly. Please enable a CSS nesting plugin *before* Tailwind in your configuration. See how here: https://tailwindcss.com/docs/using-with-preprocessors#nesting


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

