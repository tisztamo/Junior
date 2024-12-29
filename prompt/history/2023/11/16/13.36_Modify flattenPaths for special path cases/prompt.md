You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/service/helpers/flattenPaths.js:
```
const flattenPaths = (node, path = '') => {
  if (node.type === 'file') {
    return [path ? `${path}/${node.name}` : node.name];
  }
  if (!Array.isArray(node.children)) {
    return [];
  }
  return node.children.reduce((acc, child) => {
    return acc.concat(flattenPaths(child, path ? `${path}/${node.name}` : node.name));
  }, []);
};

export default flattenPaths;

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

in the ? : expression of the recursive call of flattenPath: If the path is . or ./ , do not prepend it to the name, use the name as in the case of empty path.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

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
[FULL content of the file]
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

