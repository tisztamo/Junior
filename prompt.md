# Working set

src/frontend/styles/markdown.css:
```
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';

.markdown {
  & h1 {
    @apply text-4xl font-bold mb-4;
  }

  & p {
    @apply text-base font-normal mb-4;
  }

  & pre {
    @apply bg-gray-100 p-4 font-mono;
  }
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Add styles for h2, h3 and lists!



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

