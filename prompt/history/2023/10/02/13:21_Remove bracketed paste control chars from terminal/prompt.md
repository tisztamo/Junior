You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/terminal/TerminalSummary.jsx:
```
import { createEffect, createSignal } from 'solid-js';
import { prependAndExtractLastLine } from './prependAndExtractLastLine';

export function TerminalSummary(props) {
  const [lastLineSignal, setLastLineSignal] = createSignal("");
  let localLastLine = "";

  createEffect(() => {
    localLastLine = prependAndExtractLastLine(localLastLine, props.lastWritten);
    if (localLastLine !== "") {
      setLastLineSignal(localLastLine);
    }
  });

  return <span>{lastLineSignal()}</span>;
}

```
./src/frontend/components/terminal/prependAndExtractLastLine.js:
```
export function prependAndExtractLastLine(lastLine, currentData) {
  const combinedData = `${lastLine}${currentData}`;
  const cleanedData = combinedData.replace(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]?/g, '');

  const lines = cleanedData.split(/\r(?!\n)|\n/);

  return getValidLastLine(lines);
}

function getValidLastLine(lines) {
  if (lines.length === 0) return '';

  const lastLine = lines[lines.length - 1].trim();
  if (lastLine === '' || lastLine.endsWith('$') || lastLine.endsWith('%')) {
    return getValidLastLine(lines.slice(0, -1));
  }
  
  return lastLine;
}

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Also remove bracketed paste control characters from the terminal summary, e.g.  ^[[2004h and ^[[2004l 


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

