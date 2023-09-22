You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/CommitMessageInput.jsx:
```
import { commitMessage, setCommitMessage } from '../model/commitMessage';
import monitorChange from '../model/monitorChange';
import handleCommitService from '../service/lifecycle/handleCommitService';

const CommitMessageInput = () => {
  monitorChange();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  const handleKeyPress = (e) => {
    if(e.key === 'Enter') {
      handleCommitService();
    }
  }

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} onKeyPress={handleKeyPress} />
  );
};

export default CommitMessageInput;

```

./src/frontend/components/ChangeFinalization.jsx:
```
import CommitMessageInput from './CommitMessageInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <CommitMessageInput />
      <div className="flex w-full mt-1 space-x-4">
        <RollbackButton />
        <CommitButton />
      </div>
    </>
  );
};

export default ChangeFinalization;


```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Add another input, ProofInput after the commit message
They are on the same line on the screen
commit message: 70%
Proof: 30%


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


Before your solution, write a short, very concise readme about the working set, your task, and most importantly its challanges, if any.


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


