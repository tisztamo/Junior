# Working set

src/frontend/components/GitStatusDisplay.jsx:
```
import { onMount, createEffect } from 'solid-js';
import { gitStatus, setGitStatus } from '../stores/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(async () => {
    const status = await fetchGitStatus();
    setGitStatus(status);
  });

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue && gitStatusValue.status && gitStatusValue.status !== '') {
      statusContainer.innerText = gitStatusValue.status;
    }
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() && gitStatus().status && gitStatus().status !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;

```

src/frontend/stores/gitStatus.js:
```
import { createSignal } from 'solid-js';

const [gitStatus, setGitStatus] = createSignal('');

export { gitStatus, setGitStatus };

```

src/frontend/service/fetchGitStatus.js:
```
import { getBaseUrl } from '../getBaseUrl';

const fetchGitStatus = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/status`);

  const data = await response.json();

  return data;
};

export { fetchGitStatus };

```


# Task

Fix the following issue!

Fetch should not return the result but write it to the store


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

