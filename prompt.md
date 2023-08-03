# Working set

src/frontend/components/CommitMessageInput.jsx:
```
import { onCleanup } from 'solid-js';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import monitorChangeSignal from '../stores/monitorChange';

const CommitMessageInput = (props) => {
  // Start monitoring when mounting
  monitorChangeSignal();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-64 px-4 py-2 border rounded" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} />
  );
};

export default CommitMessageInput;

```

src/frontend/stores/monitorChange.js:
```
import { createEffect } from 'solid-js';
import { change } from '../stores/change';
import { setCommitMessage } from '../stores/commitMessage';

let monitoring = false;

const monitorChangeSignal = () => {
  if (monitoring) return;

  monitoring = true;

  createEffect(() => {
    const newChangeContent = change();
    const goalLineMatch = newChangeContent.match(/goal="(.+?)"/);
    
    if (goalLineMatch) {
      const goalValue = goalLineMatch[1];
      
      setCommitMessage(goalValue);
    }
  });
};

export default monitorChangeSignal;

```


# Task

Refactor!

Rename monitorChangeSignal to monitorChange and add a short descriptive comment about the function to the very beginning of the file Remove onCleanup import from CommitMessageInput



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

