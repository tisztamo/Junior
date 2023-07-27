# Working set

src/frontend/components/GitStatusDisplay.jsx:
```
import { onMount, createEffect } from 'solid-js';
import { gitStatus } from '../stores/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(fetchGitStatus);

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue) {
      if (gitStatusValue.error && gitStatusValue.error.stderr.includes('Not a git repository')) {
        statusContainer.innerText = 'Not a git repo. Run \'npx junior-init\' to initialize!';
      } else if (gitStatusValue.message && gitStatusValue.message !== '') {
        statusContainer.innerText = gitStatusValue.message;
      }
    }
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() && gitStatus().message && gitStatus().message !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;

```

src/backend/handlers/gitStatusHandler.js:
```
import gitStatus from '../../git/gitStatus.js';

export default async function gitStatusHandler(req, res) {
  try {
    const status = await gitStatus();
    res.status(200).send({ status });
  } catch (error) {
    res.status(500).send({ message: 'Error in getting Git status', error });
  }
}

```


# Task

Fix the following issue!

1. Move the git status result from the status field of the response to the message field.
2. When the endpoint reports an error in the error field similar to this (check stderr for &#34;Not a git repository&#34;):
{
  &#34;message&#34;: &#34;Error in getting Git status&#34;,
  &#34;error&#34;: {
    &#34;code&#34;: 128,
    &#34;killed&#34;: false,
    &#34;signal&#34;: null,
    &#34;cmd&#34;: &#34;git status --porcelain=v1&#34;,
    &#34;stdout&#34;: &#34;&#34;,
    &#34;stderr&#34;: &#34;fatal: Not a git repository (or any of the parent directories): .git\n&#34;
  }
}
then display &#34;Not a git repo. Run &#39;npx junior-init&#39; to initialize!&#34;.


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

