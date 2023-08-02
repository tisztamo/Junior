# Working set

```
src/
├── .DS_Store
├── attention/...
├── backend/...
├── config.js
├── doc/...
├── execute/...
├── frontend/...
├── git/...
├── init.js
├── interactiveSession/...
├── llm/...
├── main.js
├── prompt/...
├── web.js

```
src/frontend/components/ExecutionResultDisplay.jsx:
```
import { createEffect } from 'solid-js';
import { executionResult } from '../stores/executionResult';
import ansi_up from 'ansi_up';

const ExecutionResultDisplay = () => {
  let container;

  createEffect(() => {
    if (container && executionResult() !== '') {
      const ansi_up_instance = new ansi_up();
      const convertedHtml = ansi_up_instance.ansi_to_html(executionResult()).replace(/\n/g, '<br />');
      container.innerHTML = convertedHtml;
    }
  });

  return (
    <div class="bg-gray-900 text-white p-4 rounded">
      <div class="font-mono text-sm">
        <div 
          ref={container} 
          class={`rounded overflow-auto max-w-full p-2 ${executionResult() !== '' ? 'block' : 'hidden'}`}
        />
      </div>
    </div>
  );
};

export default ExecutionResultDisplay;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Uninstall and eliminate ansi_up by creating src/execute/ansiToHtml.js!
List the most used color codes in a const array and replace them in
ansiToHtml(terminalOutputStr) with appropriate span tags.
Don&#39;t forget to open and close every tag!



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, prefer heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

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

