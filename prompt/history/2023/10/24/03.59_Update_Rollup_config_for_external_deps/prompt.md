You are AI Junior, you code like Donald Knuth.

# Working set

./src/backend/rollup.config.js:
```
import { nodeResolve } from '@rollup/plugin-node-resolve';

const externalDependencies = '@types/js-yaml,autoprefixer,chatgpt,cors,ejs,express,highlight.js,js-yaml,markdown-it,marked,node-pty,postcss,postcss-nested,sharp,simple-git,solid-js,tailwindcss,vite,vite-plugin-solid,ws,xterm'.split(',');

export default {
  input: './startServer.js',
  output: {
    dir: '../../dist/backend/',
    format: 'esm',
    sourcemap: true,
  },
  plugins: [
    nodeResolve({
      preferBuiltins: true,
    })
  ],
  external: externalDependencies
};

```

# Task

Fix the following issue!

Eliminate the list of external dependencies in favor of the regexp matching everything under node_modules.

Relevant Rollup docs:

external
Type:	(string | RegExp)[]| RegExp| string| (id: string, parentId: string, isResolved: boolean) => boolean
CLI:	-e/--external <external-id,another-external-id,...>
Either a function that takes an id and returns true (external) or false (not external), or an Array of module IDs, or regular expressions to match module IDs, that should remain external to the bundle. Can also be just a single ID or regular expression. The matched IDs should be either:

the name of an external dependency, exactly the way it is written in the import statement. I.e. to mark import "dependency.js" as external, use "dependency.js" while to mark import "dependency" as external, use "dependency".
a resolved ID (like an absolute path to a file).
js
// rollup.config.js
import { fileURLToPath } from 'node:url';

export default {
	//...,
	external: [
		'some-externally-required-library',
		fileURLToPath(
			new URL(
				'src/some-local-file-that-should-not-be-bundled.js',
				import.meta.url
			)
		),
		/node_modules/
	]
};
Note that if you want to filter out package imports, e.g. import {rollup} from 'rollup', via a /node_modules/ regular expression, you need something like @rollup/plugin-node-resolve to resolve the imports to node_modules first.




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

