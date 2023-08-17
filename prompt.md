# Working set

src/frontend/service/fetchGitStatus.js:
```
import { getBaseUrl } from '../getBaseUrl';
import { setGitStatus } from '../model/gitStatus';

const fetchGitStatus = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/status`);

  const data = await response.json();

  setGitStatus(data);
};

export { fetchGitStatus };

```

src/frontend/service/resetGit.js:
```
import { getBaseUrl } from '../getBaseUrl';

const resetGit = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/reset`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
  });

  const data = await response.json();

  return data;
};

export { resetGit };

```

src/frontend/service/postCommit.js:
```
import { getBaseUrl } from '../getBaseUrl';

const postCommit = async (message) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/commit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message }),
  });

  const data = await response.json();

  return data;
};

export { postCommit };

```


# Task

Refactor!

Git-related routes were moved under /git/



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

