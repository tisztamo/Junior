# Working set

src/frontend/components/PromptDisplay.jsx:
```
import { createSignal, onMount, createEffect } from "solid-js";
import { prompt } from '../stores/prompt';

const PromptDisplay = () => {
  let div;
  let summary;

  createEffect(() => {
    if (div) {
      div.innerHTML = prompt();
      summary.innerHTML = `prompt length: ${prompt().length} chars`;
    }
  });

  return (
    <details class="w-full max-w-screen overflow-x-auto whitespace-normal markdown">
      <summary ref={summary}></summary>
      <div ref={div}></div>
    </details>
  );
};

export default PromptDisplay;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!
- Every js file should only export a single function!
- Use ES6 imports!

Requirements:

When the prompt is empty, do not show the details tag



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

