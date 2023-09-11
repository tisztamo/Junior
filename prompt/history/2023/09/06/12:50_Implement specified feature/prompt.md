You are AI Junior, you code like Donald Knuth.
# Working set

src/prompt/createPromptYaml.js:
```
import { writeFileSync } from 'fs';

export function createPromptYaml() {
  const yamlContent = `task: prompt/task/feature/implement.md
attention:
  - ./
requirements: Create a Hello World in Node.js`;

  writeFileSync('prompt.yaml', yamlContent);
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

1. Delete prompt/defaults/prompt.yaml 2. In createPromptYaml, replace the requirements section to multiline using | with the following content:
  1. Create the src/ dir
  2. Create src/main.js with a Hello World in Node.js
  3. Update package.json to enable running it.
  4. Print instructions on how to run it.


## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx file accordingly!


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

