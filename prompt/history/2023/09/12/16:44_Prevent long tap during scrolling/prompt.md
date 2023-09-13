You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/MultiSelect/LongTapDetector.js:
```
import { onCleanup } from 'solid-js';

const useLongTap = (callback, duration = 500) => {
  let timer;

  const startLongTapDetection = () => {
    timer = setTimeout(callback, duration);
  };

  const cancelLongTapDetection = () => {
    clearTimeout(timer);
  };

  onCleanup(() => {
    clearTimeout(timer);
  });

  return {
    onTouchStart: startLongTapDetection,
    onTouchEnd: cancelLongTapDetection,
    onMouseDown: startLongTapDetection,
    onMouseUp: cancelLongTapDetection,
    onMouseLeave: cancelLongTapDetection
  };
};

export default useLongTap;

```


# Task

Fix the following issue!

Scrolling should prevent long tap


## Project Specifics

- Every js file should *only export a single function or signal*!
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


