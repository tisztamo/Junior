You are AI Junior, you code like Donald Knuth.
# Working set

src/frontend/service/fetchDescriptor.js:
```
import { getBaseUrl } from '../getBaseUrl';

export const fetchDescriptor = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/descriptor`);
  const text = await response.text();
  return text;
};

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create service/sampleService.js same-name fn in it, content based on this, except that it should default export instead of named


## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!
- Remove _all existing comments_ from the code!
- Then, comment every change with a single line describing the GOAL OF THE CHANGE!


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

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

