# Working set

src/frontend/components/CommitButton.jsx:
```
import { postCommit } from '../service/postCommit';
import { commitMessage } from '../stores/commitMessage';

const CommitButton = () => {
  const handleCommit = async () => {
    const response = await postCommit(commitMessage());
    console.log(response.message);
  };

  return (
    <button class="w-64 px-4 py-4 bg-green-700 text-white rounded mt-2" onClick={handleCommit}>Commit</button>
  );
};

export default CommitButton;

```

src/frontend/components/CommitMessageInput.jsx:
```
import { commitMessage, setCommitMessage } from '../stores/commitMessage';

const CommitMessageInput = (props) => {
  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" class="w-64 px-4 py-2 border rounded" placeholder="Commit message..." onInput={handleChange} />
  );
};

export default CommitMessageInput;

```


# Task

Refactor!

After commit, fetch git status 



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

