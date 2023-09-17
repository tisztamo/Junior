This is not working, maybe our runtime consumes too much overhead. Did not checked but guess that it can solve this without the bloated change.sh, and other formatting requirements. (This is not the way to go formatting-wise anyway, we have to refactor to named exports.)

prompt.yaml:
```yaml
task: prompt/task/feature/implement.md
attention:
  - ./src/frontend/service/clearState.js
  - ./src/frontend/model/gitStatus.js
  - ./src/frontend/service/fetchGitStatus.js
requirements: >-
  The git status is now an object, not string. Also update non-conforming
  exports in provided files and their imports, but do not change imports of
  non-provided files.
os: OSX
```

prompt.md:
```md
You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/service/clearState.js:
```
import { setChange } from '../model/change';
import { setExecutionResult } from '../model/executionResult';
import { setCommitMessage } from '../model/commitMessage';
import { setPrompt } from '../model/prompt';
import { setGitStatus } from '../model/gitStatus';

const clearState = () => {
  setChange('');
  setExecutionResult('');
  setCommitMessage('');
  setPrompt('');
  setGitStatus('');
};

export default clearState;

```

./src/frontend/model/gitStatus.js:
```
import { createSignal } from 'solid-js';

const [gitStatus, setGitStatus] = createSignal('');

export { gitStatus, setGitStatus };

```

./src/frontend/service/fetchGitStatus.js:
```
import { getBaseUrl } from '../getBaseUrl';
import { setGitStatus } from '../model/gitStatus';

const fetchGitStatus = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/status`);

  const data = await response.json();

  setGitStatus(data);
};

export { fetchGitStatus };

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

The git status is now an object, not string. Also update non-conforming exports in provided files and their imports, but do not change imports of non-provided files.


## Project Specifics

- Every js file should *only export a single function or signal, as default*! eg.: in createGitRepo.js: export default function createGitRepo ( ....
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

Before starting, check if you need more files or info to solve the task.

If the task is not clear:

EXAMPLE START
I need more information to solve the task. [Description of the missing info]
EXAMPLE END

Do not edit files not provided in the working set!
If you need more files:

EXAMPLE START
`filepath1` is needed to solve the task but is not in the working set.
EXAMPLE END

```
