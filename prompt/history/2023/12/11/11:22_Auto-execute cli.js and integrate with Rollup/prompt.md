You are AI Junior, you code like Donald Knuth.

# Task

Fix the following issue!

Edit cli.js to auto-execute the main function instead of exporting it. Also build cli.js with rollup like the other files in bin.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: Debian


Installed tools: npm, jq


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"

# Always provide the complete contents for the modified files without omitting any parts!
cat > x.js << EOF
  let i = 1
  console.log(\`i: \${i}\`)
EOF
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

# Working set

src/backend/rollup.config.js:
```
import { nodeResolve } from '@rollup/plugin-node-resolve';
import shebang from 'rollup-plugin-preserve-shebang';
import { makeExecutableRollupPlugin } from './build/makeExecutableRollupPlugin.js';

const BIN_PATH = '../../bin/';
const DIST_PATH = '../../dist/';

const commonConfig = {
  output: {
    format: 'esm'
  },
  plugins: [
    nodeResolve({
      preferBuiltins: true,
    }),
    shebang(),
    makeExecutableRollupPlugin()
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
bin/cli.js:
```
#!/usr/bin/env node

import { startInteractiveSession } from '../src/interactiveSession/startInteractiveSession.js';
import { getApi, get_model, rl } from '../src/config.js';

(async () => {
  console.log("Welcome to Junior. Model: " + get_model() + "\n");
  const api = await getApi();
  startInteractiveSession(rl, api);
})();

export { startInteractiveSession };

```