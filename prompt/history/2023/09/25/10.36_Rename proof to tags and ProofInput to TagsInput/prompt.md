You are AI Junior, you code like Donald Knuth.

# Working set

./src/frontend/model/proofModel.js:
```
import { createSignal } from 'solid-js';

const [proof, setProof] = createSignal('');

export { proof, setProof };

```
./src/frontend/components/ProofInput.jsx:
```
import { createSignal } from 'solid-js';
import { proof, setProof } from '../model/proofModel';

const ProofInput = () => {
  const handleChange = (e) => {
    setProof(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Proof..." value={proof()} onInput={handleChange} />
  );
};

export default ProofInput;

```
./src/backend/handlers/git/commitGitHandler.js:
```
import commitGit from '../../../git/commitGit.js';

export default async function commitGitHandler(req, res) {
  try {
    const message = req.body.message;
    const proof = req.body.proof;
    
    if (!message) {
      res.status(400).send({ message: 'Commit message is required' });
      return;
    }

    let finalMessage = message;
    if (proof && proof.trim() !== "") {
      finalMessage = `${message} ${proof}`;
    }
    
    await commitGit(finalMessage);
    res.status(200).send({ message: `Successfully committed with message: ${finalMessage}` });
  } catch (error) {
    res.status(500).send({ message: 'Error in committing changes', error });
  }
}

```
./src/frontend/service/clearState.js:
```
import { setChange } from '../model/change';
import { setExecutionResult } from '../model/executionResult';
import { setCommitMessage } from '../model/commitMessage';
import { setPrompt } from '../model/prompt';
import { setGitStatus } from '../model/gitStatus';
import { setProof } from '../model/proofModel';

const clearState = () => {
  setChange('');
  setExecutionResult('');
  setCommitMessage('');
  setPrompt('');
  setGitStatus('');
  setProof('');
};

export default clearState;

```
./src/frontend/components/ChangeFinalization.jsx:
```
import CommitMessageInput from './CommitMessageInput';
import ProofInput from './ProofInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <div className="flex w-full space-x-4">
        <div className="flex-grow w-3/4">
          <CommitMessageInput />
        </div>
        <div className="w-1/4">
          <ProofInput />
        </div>
      </div>
      <div className="flex w-full mt-1 space-x-4">
        <RollbackButton />
        <CommitButton />
      </div>
    </>
  );
};

export default ChangeFinalization;


```
./src/frontend/service/lifecycle/handleCommitService.js:
```
import postCommit from '../postCommit';
import postDescriptor from '../postDescriptor';
import { commitMessage } from '../../model/commitMessage';
import { proof } from '../../model/proofModel';
import { fetchGitStatus } from '../fetchGitStatus';
import clearState from '../clearState';

export default async function handleCommitService() {
  const response = await postCommit(commitMessage(), proof());
  console.log(response.message);
    
  await postDescriptor({ requirements: '' });
    
  const status = await fetchGitStatus();
  console.log(status);
  clearState();
}

```
./src/frontend/service/postCommit.js:
```
import { getBaseUrl } from '../getBaseUrl';

const postCommit = async (message, proof) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/commit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message, proof }),
  });

  const data = await response.json();

  return data;
};

export default postCommit;

```

# Task

Refactor by renaming!

Rename "proof" to "tags" and ProofInput to TagsInput.

When renaming files:
- Ensure that other source files importing the renamed ones get updated, even if not in the working set.
- Remove the old versions of the renamed files


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files.

OS: Debian


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

