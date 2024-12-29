You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/AutoGrowingTextarea.jsx:
```
import { createEffect } from 'solid-js';

const AutoGrowingTextarea = (props) => {
  let textRef;
  
  const resize = () => {
    textRef.style.height = 'auto';
    textRef.style.height = textRef.scrollHeight + 'px';
  }

  // Handle the input event by calling resize and any onInput function provided in props
  const handleInput = (event) => {
    if (props.onInput) {
      props.onInput(event);
    }
    resize();
  }

  createEffect(() => {
    if (props.valueSignal) {
      props.valueSignal();
    }
    resize();
  });

  return (
    <textarea
      {...props}
      ref={textRef}
      onInput={handleInput}
      rows="1"
      style="overflow:hidden"
      value={props.valueSignal ? props.valueSignal() : props.value}
    />
  );
};

export default AutoGrowingTextarea;

```


# Task

Fix the following issue!

AutoGrowingTextarea  fails to grow on load.


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


