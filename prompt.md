# Working set

src/frontend/components/CommitMessageInput.jsx:
```
import { onCleanup } from 'solid-js';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import monitorChangeSignal from '../service/monitorChangeSignal';

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

src/frontend/service/monitorChangeSignal.js:
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

Move the following files to the specified target dirs!

Find out the best target dir if it is not specified!

You need to follow dependencies to maintain coherence.

Before executing, write a concise plan! The plan should show:
 - How do you avoid breaking other parts of the code.
 - If you had to choose, your way of thinking.

Move monitorChangeSignal.js to src/frontend/stores/ and rename it to monitorChange.js


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

