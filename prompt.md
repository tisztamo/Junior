# Working set

src/frontend/components/ExecutionResultDisplay.jsx:
```
import { onMount, createEffect } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';
import { executionResult } from '../stores/executionResult';

const ExecutionResultDisplay = () => {
  let container;
  let term;

  onMount(() => {
    term = new Terminal();
    term.open(container);
  });

  createEffect(() => {
    if (term) {
 term.write(executionResult());
    }
  });

  return (
    <div ref={container} class="px-4 py-4 bg-gray-300 text-black rounded overflow-auto max-w-full"></div>
  );
};

export default ExecutionResultDisplay;

```


# Task

Fix the following issue!

Fix newline handling with new Terminal({convertEol: true});


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.
OS: Debian
Installed tools: npm, jq
Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

