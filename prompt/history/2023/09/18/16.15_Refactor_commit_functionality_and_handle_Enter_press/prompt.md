You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/CommitMessageInput.jsx:
```
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import monitorChange from '../model/monitorChange';

const CommitMessageInput = () => {
  monitorChange();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} />
  );
};

export default CommitMessageInput;

```

./src/frontend/components/CommitButton.jsx:
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
    
    await postDescriptor({ requirements: '' });
    
    const status = await fetchGitStatus();
    console.log(status);
    clearState();
  };

  return (
    <button className="w-full px-4 py-4 bg-green-500 text-lg text-bg font-semibold rounded" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Pressing Enter in the commit message should commit.

To solve:
 - Factor handleCommit out to service/lifecycle/ (create this dir).
 - Use the new function in both file.

Double check import paths while moving code!


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


Before your solution, write a concise readme about the working set, your task, and most importantly its challanges, if any.


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


