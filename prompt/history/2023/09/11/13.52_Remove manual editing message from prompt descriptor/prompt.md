You are AI Junior, you code like Donald Knuth.
# Working set

/./src/frontend/components/PromptDescriptor.jsx:
```
import { onMount, onCleanup } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { useWebsocket } from '../service/useWebsocket';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor';
import { descriptorFileName } from '../../prompt/promptDescriptorConfig';

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
    <details class="w-full max-w-screen overflow-x-auto whitespace-normal">
      <summary class="font-mono">{descriptorFileName} <span class="text-sm font-normal">(Edit the attention manually)</span></summary>
      <div class="mt-4 overflow-auto max-w-full">
        <div class="whitespace-pre-wrap overflow-x-scroll overflow-y-auto font-mono">
          {promptDescriptor()}
        </div>
      </div>
    </details>
  );
};

export default PromptDescriptor;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

In the prompt descriptor, do not print the msg about manual editing.


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

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

