You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/service/lifecycle/handleCommitService.js:
```
import { postCommit } from '../postCommit';
import postDescriptor from '../postDescriptor';
import { commitMessage } from '../../model/commitMessage';
import { fetchGitStatus } from '../fetchGitStatus';
import clearState from '../clearState';

export default async function handleCommitService() {
  const response = await postCommit(commitMessage());
  console.log(response.message);
    
  await postDescriptor({ requirements: '' });
    
  const status = await fetchGitStatus();
  console.log(status);
  clearState();
}

```

./src/frontend/components/ProofInput.jsx:
```
import { createSignal } from 'solid-js';

const ProofInput = () => {
  const [proof, setProof] = createSignal('');

  const handleChange = (e) => {
    setProof(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Proof..." value={proof()} onInput={handleChange} />
  );
};

export default ProofInput;

```

./src/frontend/model/sampleModel.js:
```
import { createSignal } from 'solid-js';

const [sample, setSample] = createSignal('');

export { sample, setSample };

```

./src/frontend/service/postCommit.js:
```
import { getBaseUrl } from '../getBaseUrl';

const postCommit = async (message) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/commit`, {
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

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Add Proof value to the commit request:
- Move the proof signal to a model
- Include the value in the "proof" field of the commit request
- Change the signature of postCommit to (message, proof), where both are strings, not objects.


## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
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


