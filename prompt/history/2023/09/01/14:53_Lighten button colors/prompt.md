You are AI Junior, you code like Donald Knuth.
# Working set

src/frontend/components/CommitButton.jsx:
```
import { postCommit } from '../service/postCommit';
import postDescriptor from '../service/postDescriptor';
import { commitMessage } from '../model/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import clearState from '../service/clearState';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    
    await postDescriptor({ requirements: '', attention: '' });
    
    const status = await fetchGitStatus();
    console.log(status);
    clearState();
  };

  return (
    <button className="w-full px-4 py-4 bg-green-700 text-lg text-bg font-semibold rounded" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;

```

src/frontend/components/RollbackButton.jsx:
```
import { createSignal } from "solid-js";
import { resetGit } from '../service/resetGit';
import RollbackConfirmationDialog from './RollbackConfirmationDialog';
import clearState from '../service/clearState';

const RollbackButton = () => {
  const [showConfirmation, setShowConfirmation] = createSignal(false);

  const handleReset = async () => {
    const response = await resetGit();
    console.log(response.message);
    clearState();
  };

  const handleConfirm = () => {
    setShowConfirmation(false);
    handleReset();
  };

  const handleRollbackClick = () => {
    const disableConfirmation = localStorage.getItem('Junior.disableRollbackConfirmation') === 'true';
    if (disableConfirmation) {
      handleReset();
    } else {
      setShowConfirmation(true);
    }
  };

  return (
    <>
      <button className="w-full px-4 py-4 bg-red-700 text-lg text-bg font-semibold rounded" onClick={handleRollbackClick}>Roll Back</button>
      <RollbackConfirmationDialog visible={showConfirmation()} onConfirm={handleConfirm} onCancel={() => setShowConfirmation(false)} />
    </>
  );
};

export default RollbackButton;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Make the button colors lighter


## Project Specifics

- Every js file should *only export a single function or signal*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!
- Remove _all existing comments_ from the code!
- Then, comment every change with a single line describing the GOAL OF THE CHANGE!


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

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

