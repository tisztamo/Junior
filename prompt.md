# Working set

src/frontend/styles/colors.css:
```
:root {
  --text-color: #1a202c;
  --background-color: #f7fafc;
  --emphasize-color: #16181f;
  --background-emphasize-color: #f2f4f6;
}

.dark {
  --text-color: #f7fafc;
  --background-color: #1a202c;
  --emphasize-color: #f2f4f6;
  --background-emphasize-color: #141618;
}

```

src/frontend/styles/markdown.css:
```
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';

.markdown {
  & h1 {
    @apply text-4xl font-bold mb-4;
  }

  & h2 {
    @apply text-3xl font-bold mb-3;
  }

  & h3 {
    @apply text-2xl font-semibold mb-2;
  }

  & p {
    @apply text-base font-normal mb-4;
  }

  & ul, & ol {
    @apply list-decimal list-inside mb-4;
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

Use the --emphasize-color and --background-emphasize-color variables for code blocks.



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

