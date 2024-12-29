You are AI Junior, you code like Donald Knuth.

# Working set

./src/execute/ansiToHtml.js:
```
const ANSI_COLORS = {
  '30': 'black',
  '31': 'red',
  '32': 'lightgreen',
  '33': 'yellow',
  '34': 'blue',
  '35': 'magenta',
  '36': 'cyan',
  '37': 'white',
};

const ansiToHtml = (terminalOutputStr) => {
  if (!terminalOutputStr) return '';
  let result = '<span>' + terminalOutputStr.replace(/\033\[([0-9]+)m/g, (match, p1) => {
    const color = ANSI_COLORS[p1];
    return color ? `</span><span style="color:${color}">` : '</span><span>';
  });
  result += '</span>';
  return result.replace(/\n/g, '<br />');
};

export default ansiToHtml;

```
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

  return (
    <span className="font-mono pl-4 whitespace-nowrap overflow-ellipsis overflow-hidden">
      {lastLineSignal()}
    </span>
  );
}

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Call ansiToHtml on the last line before setting the signal, and inject it to the innerHtml to allow coloring. 

FYI the docs says:

#innerHTML/textContent
These work the same as their property equivalent. Set a string and they will be set. Be careful!! Setting innerHTML with any data that could be exposed to an end user as it could be a vector for malicious attack. textContent while generally not needed is actually a performance optimization when you know the children will only be text as it bypasses the generic diffing routine.

<div textContent={state.text} />


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

