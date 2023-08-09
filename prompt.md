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


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Ask the user if really want to rollback: it will reset the repo to the last commit and delete new files even if they were not created by Junior.



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

