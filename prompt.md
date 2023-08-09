# Working set

src/frontend/components/ExecutionResultDisplay.jsx:
```
import { createEffect, createSignal } from 'solid-js';
import { executionResult } from '../model/executionResult';
import ansiToHtml from '../../execute/ansiToHtml';

const ExecutionResultDisplay = () => {
  let container;
  const [copyText, setCopyText] = createSignal('copy');

  const copyToClipboard = async (e) => {
    e.preventDefault(); // Prevent page load on click
    try {
      await navigator.clipboard.writeText(executionResult());
      setCopyText('copied');
      setTimeout(() => setCopyText('copy'), 2000);
    } catch (err) {
      alert("Failed to copy text!");
      console.warn("Copy operation failed:", err);
    }
  };

  createEffect(() => {
    if (container && executionResult() !== '') {
      const convertedHtml = ansiToHtml(executionResult());
      container.innerHTML = convertedHtml;
    }
  });

  return (
    <div class={`relative bg-gray-900 text-white p-4 rounded ${executionResult() !== '' ? 'block' : 'hidden'}`}>
      <a href="#" class="underline absolute top-0 right-0 m-4" onClick={copyToClipboard}>{copyText()}</a>
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
  '32': 'lightgreen',
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

Fix the following issue!

Uncaught (in promise) TypeError: Cannot read properties of undefined (reading &#39;replace&#39;)
  at ansiToHtml (ansiToHtml.js:13:45)
  at Object.fn (ExecutionResultDisplay.jsx:31:29)


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

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

