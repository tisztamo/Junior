# Working set

```
src/frontend/
├── App.jsx
├── assets/...
├── components/...
├── fetchTasks.js
├── generatePrompt.js
├── getBaseUrl.js
├── index.html
├── index.jsx
├── postcss.config.cjs
├── service/...
├── startVite.js
├── stores/...
├── styles/...
├── tailwind.config.cjs
├── vite.config.js

```
```
src/frontend/service/
├── createWebSocket.js
├── executeChange.js
├── fetchDescriptor.js
├── fetchGitStatus.js
├── handleTaskChange.js
├── parseYamlAndGetTask.js
├── postCommit.js
├── resetGit.js
├── useWebsocket.js

```
src/frontend/stores/change.js:
```
import { createSignal } from 'solid-js';

export const [change, setChange] = createSignal('');

```

src/frontend/stores/commitMessage.js:
```
import { createSignal } from 'solid-js';

const [commitMessage, setCommitMessage] = createSignal('');

export { commitMessage, setCommitMessage };

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create a function in the servitce directory, which, when called, starts to
monitor the change signal, parses its content, which should be a shells script,
for a line:
goal=&#34;Some goal description&#34;
and if found, sets the commit message to the value of this goal variable



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

