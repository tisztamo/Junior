You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/GitStatusRow.jsx:
```
import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;
  const bgColor = getBackgroundColorForFile(index, path);
  return (
    <div class={`flex ${bgColor ? 'bg-' + bgColor : ''}`}>
      <span class="w-50px">{index}</span>
      <span class="flex-grow w-60%">{path}</span>
      <span class="flex-shrink">{working_dir}</span>
    </div>
  );
};

export default GitStatusRow;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Render index and working_dir fields concatenated in the first column. Cut the filename from path and print it in the second column, and render the remaining base dir in the third.
If text does not fit in any of the columns, scroll in the cell, not in the row.


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


Do NOT write any text outside the script!

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


