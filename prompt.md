# Working set

src/frontend/components/RollbackButton.jsx:
```
import { resetGit } from '../service/resetGit';

const RollbackButton = () => {
  const handleReset = async () => {
    const response = await resetGit();

    console.log(response.message);
  };

  return (
    <button className="w-full px-4 py-4 bg-red-700 text-white rounded" onClick={handleReset}>Roll Back</button>
  );
};

export default RollbackButton;


```

src/frontend/components/CommitButton.jsx:
```
import { postCommit } from '../service/postCommit';
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { setExecutionResult } from '../model/executionResult';
import { setPrompt } from '../model/prompt';
import { setChange } from '../model/change';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
    const status = await fetchGitStatus();
    console.log(status);
    setChange(''); // Clearing the change after commit
    setExecutionResult('');
    setCommitMessage('');
    setPrompt('');
  };

  return (
    <button className="w-full px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;

```


# Task

Fix the following issue!

Make CommitButton look exactly the same as rollback, except color!


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

