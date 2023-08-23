You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

src/frontend/components/PromptDescriptor.jsx:
```
import { onMount, onCleanup } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { useWebsocket } from '../service/useWebsocket';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor';

const PromptDescriptor = () => {

  onMount(async () => {
    const text = await fetchDescriptor();
    setPromptDescriptor(text);
  });

  useWebsocket(async (e) => {
    if (e.data === 'update') {
      const text = await fetchDescriptor();
      setPromptDescriptor(text);
      // Fetch git status when an update event is received
      fetchGitStatus();
    }
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <div class="overflow-auto max-w-full">
      <div class="whitespace-pre-wrap overflow-x-scroll overflow-y-auto font-mono">
        {promptDescriptor()}
      </div>
    </div>
  );
};

export default PromptDescriptor;

```

src/prompt/promptDescriptorConfig.js:
```
export const descriptorFileName = "prompt.yaml";

```

src/frontend/components/PromptDisplay.jsx:
```
import { createSignal, onMount, createEffect } from "solid-js";
import { prompt } from '../model/prompt';

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
    <details class="w-full max-w-screen overflow-x-auto whitespace-normal markdown" style={{ display: prompt().length > 0 ? 'block' : 'none' }}>
      <summary ref={summary}></summary>
      <div ref={div} class="mt-4"></div>
    </details>
  );
};

export default PromptDisplay;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Wrap the prompt descriptor in a html details tag. Its header is the descriptor filename with mono font. Otherwise style it like the one in PromptDisplay



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx file accordingly!


# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

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

