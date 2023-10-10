You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/components/DetailsComponent.jsx:
```
import { createSignal, onCleanup, onMount } from 'solid-js';

const DetailsComponent = (props) => {
  const [isOpen, setIsOpen] = createSignal(props.defaultState === 'open');

  // On mount, check local storage and set state accordingly
  onMount(() => {
    const savedState = localStorage.getItem("Junior.terminal.isOpen");
    if (savedState) {
      setIsOpen(savedState === 'true');
    }
  });

  // Update local storage whenever isOpen changes
  const updateLocalStorage = () => {
    // Capture the open state from the details tag before saving
    const currentState = event.currentTarget.open;
    setIsOpen(currentState);
    localStorage.setItem("Junior.terminal.isOpen", currentState ? 'true' : 'false');
  };

  const classes = props.classes || "";

  return (
    <details class={classes} open={isOpen()} onToggle={updateLocalStorage}>
      <summary class="px-2">
        <span class="pl-2">{props.generateHeader()}</span>
      </summary>
      <div class="pt-2">
        {props.children}
      </div>
    </details>
  );
};

export default DetailsComponent;

```

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Eliminate the use of the details tag in favor of using divs and creating the openable layout with tailwind classes.
Use unicode chars for displaying the state: A triangle pointing to left when closed, and pointing down when opened.


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

