# Working set

src/frontend/components/GitStatusDisplay.jsx:
```
import { onMount, createEffect, onCleanup } from 'solid-js';
import { gitStatus, setGitStatus } from '../stores/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(async () => {
    const status = await fetchGitStatus();
    setGitStatus(status);
  });

  createEffect(() => {
    if (gitStatus() !== '') {
      statusContainer.innerText = gitStatus();
    }
  });

  onCleanup(() => {
    setGitStatus('');
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;

```


# Task

Fix the following issue!

gitStatus returns an object with status field.


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

