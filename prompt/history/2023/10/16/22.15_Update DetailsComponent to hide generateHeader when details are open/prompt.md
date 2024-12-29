You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/DetailsComponent.jsx:
```
import { createSignal, onCleanup, onMount } from 'solid-js';

const DetailsComponent = (props) => {
  const [isOpen, setIsOpen] = createSignal(props.defaultState === 'open');

  // Unicode characters for open and close states.
  const closeChar = '\u25B6';  // Right-pointing triangle
  const openChar = '\u25BC';  // Down-pointing triangle
  
  onMount(() => {
    const savedState = localStorage.getItem("Junior.terminal.isOpen");
    if (savedState) {
      setIsOpen(savedState === 'true');
    }
  });
  
  const updateLocalStorage = (currentState) => {
    setIsOpen(currentState);
    localStorage.setItem("Junior.terminal.isOpen", currentState ? 'true' : 'false');
  };

  const classes = props.classes || "";
  const toggleDetails = () => updateLocalStorage(!isOpen());

  return (
    <div class={classes}>
      <div class="px-2 cursor-pointer" onClick={toggleDetails}>
        <span class="pl-1 pr-2">{isOpen() ? openChar : closeChar}</span>{props.generateHeader()}
      </div>
      <div class={`transition-height duration-300 ${isOpen() ? 'block' : 'hidden'} pt-2`}>
        {props.children}
      </div>
    </div>
  );
};

export default DetailsComponent;

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Do not display the result of generateHeader when the details is opened


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

