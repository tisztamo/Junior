You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/GitStatusDisplay.jsx:
```
import { onMount, createEffect } from 'solid-js';
import getBackgroundColorForFile from './getBackgroundColorForFile';
import { gitStatus } from '../model/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(fetchGitStatus);

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue) {
      if (gitStatusValue.error) {
        statusContainer.innerText = `${gitStatusValue.message}\n${gitStatusValue.error.stderr}`;
      } else if (gitStatusValue.data && gitStatusValue.data.files && gitStatusValue.data.files.length > 0) {
        statusContainer.innerHTML = gitStatusValue.data.files.map(entry => {
          const { index, path, working_dir } = entry;
          const bgColor = getBackgroundColorForFile(index, path);
          return `<div class="grid grid-cols-3 ${bgColor ? 'bg-' + bgColor : ''}">
                    <span class="col-span-1 w-50px">${index}</span>
                    <span class="col-span-1 w-60%">${path}</span>
                    <span class="col-span-1">${working_dir}</span>
                  </div>`;
        }).join('');
      }
    }
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() && gitStatus().data && gitStatus().data.files && gitStatus().data.files.length > 0 ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;

```


# Task

Refactor!

Factor the rendering of a single row out to
GitStatusRow.jsx
While doing so, also eliminate innerHTML use!
Render normally, using jsx/solid.
Simplify, if possible.


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


