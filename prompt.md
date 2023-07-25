# Working set

prompt/task/bug/fix.md:
```
Fix the following issue!

<%= requirements %>
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

[vite:css] Nested CSS was detected, but CSS nesting has not been configured correctly. Please enable a CSS nesting plugin *before* Tailwind in your configuration.
We already have one, try the config in the tailwind docs:
// postcss.config.js module.exports = {
  plugins: {
    &#39;postcss-import&#39;: {},
    &#39;tailwindcss/nesting&#39;: {},
    tailwindcss: {},
    autoprefixer: {},
  }
}
No need to install anything.
Also rename our config file to .cjs before applying the change so we can avoid import issues.


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

