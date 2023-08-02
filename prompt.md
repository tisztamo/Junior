# Working set

src/frontend/components/ExecutionResultDisplay.jsx:
```
import { createEffect } from 'solid-js';
import { executionResult } from '../stores/executionResult';
import ansiToHtml from '../../execute/ansiToHtml';

const ExecutionResultDisplay = () => {
  let container;

  createEffect(() => {
    if (container && executionResult() !== '') {
      const convertedHtml = ansiToHtml(executionResult());
      container.innerHTML = convertedHtml;
    }
  });

  return (
    <div class={`bg-gray-900 text-white p-4 rounded ${executionResult() !== '' ? 'block' : 'hidden'}`}>
      <div class="font-mono text-sm">
        <div ref={container} class="rounded overflow-auto max-w-full p-2" />
      </div>
    </div>
  );
};

export default ExecutionResultDisplay;

```

src/execute/ansiToHtml.js:
```
const ANSI_COLORS = {
  '30': 'black',
  '31': 'red',
  '32': 'green',
  '33': 'yellow',
  '34': 'blue',
  '35': 'magenta',
  '36': 'cyan',
  '37': 'white',
};

const ansiToHtml = (terminalOutputStr) => {
  let result = '<span>' + terminalOutputStr.replace(/\033\[([0-9]+)m/g, (match, p1) => {
    const color = ANSI_COLORS[p1];
    return color ? `</span><span style="color:${color}">` : '</span><span>';
  });
  result += '</span>';
  return result.replace(/\n/g, '<br />');
};

export default ansiToHtml;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

- Use lightgreen instead of green
- Add a &#34;copy&#34; link floating over the top right of the execution display
which when clicked, copies the original execution result (not the html)



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

