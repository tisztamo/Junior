You are AI Junior, you code like Donald Knuth.
# Working set

./src/backend/fileutils/getIgnoreList.js:
```
function getIgnoreList() {
  const DEFAULT_IGNORE = ['.git', 'node_modules', './prompt'];

  const cliArgs = process.argv.slice(2);
  const cliIgnore = cliArgs
    .filter(arg => arg.startsWith('--ignore='))
    .map(arg => arg.replace('--ignore=', '').split(','))
    .flat();

  const envIgnore = process.env.JUNIOR_IGNORE ? process.env.JUNIOR_IGNORE.split(',') : [];

  const totalIgnore = [...DEFAULT_IGNORE, ...cliIgnore, ...envIgnore];

  const nameIgnore = totalIgnore.filter(item => !item.startsWith('./'));
  const pathIgnore = totalIgnore.filter(item => item.startsWith('./')).map(item => item.slice(2));

  return { nameIgnore, pathIgnore };
}

export default getIgnoreList;


```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Add "dist", "build", "tmp", "temp" and at least 5 but up to 100 reasonable entries to the ignore list!


## Project Specifics

- Every js file should *only export a single function or signal, as default*! eg.: in createGitRepo.js: export default function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: OSX

Installed tools: npm, jq


Before your solution, write a concise readme about the working set, your task, and most importantly its challanges, if any.


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


