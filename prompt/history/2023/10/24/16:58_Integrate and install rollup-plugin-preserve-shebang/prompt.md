You are AI Junior, you code like Donald Knuth.

# Working set

./src/backend/rollup.config.js:
```
import { nodeResolve } from '@rollup/plugin-node-resolve';

const BIN_PATH = '../../bin/';
const DIST_PATH = '../../dist/';

const commonConfig = {
  output: {
    format: 'esm'
  },
  plugins: [
    nodeResolve({
      preferBuiltins: true,
    })
  ],
  external: [/node_modules/]
};

export default [
  {
    ...commonConfig,
    input: './startServer.js',
    output: {
      ...commonConfig.output,
      dir: `${DIST_PATH}backend/`
    }
  },
  {
    ...commonConfig,
    input: `${BIN_PATH}init.js`,
    output: {
      ...commonConfig.output,
      dir: `${DIST_PATH}bin/`
    }
  },
  {
    ...commonConfig,
    input: `${BIN_PATH}rollback.js`,
    output: {
      ...commonConfig.output,
      dir: `${DIST_PATH}bin/`
    }
  },
  {
    ...commonConfig,
    input: `${BIN_PATH}web.js`,
    output: {
      ...commonConfig.output,
      dir: `${DIST_PATH}bin/`
    }
  }
];

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:




## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"
cat > x.js << 'EOF'
[...]
'EOF'
echo "\033[32mDone: $goal\033[0m\n"
```
EXAMPLE END

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END

