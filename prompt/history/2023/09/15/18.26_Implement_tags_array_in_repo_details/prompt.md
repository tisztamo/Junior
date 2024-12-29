You are AI Junior, you code like Donald Knuth.
# Working set

./src/frontend/components/RepoInfo.jsx:
```
import { createSignal, onCleanup } from 'solid-js';
import fetchRepoInfo from '../service/fetchers/fetchRepoInfo';

const RepoInfo = () => {
    const [repoInfo, setRepoInfo] = createSignal({});
    const [expanded, setExpanded] = createSignal(false);

    // Fetch the repo info on component mount and set it to state
    const fetchAndSetRepoInfo = async () => {
        const data = await fetchRepoInfo();
        setRepoInfo(data);
    }

    fetchAndSetRepoInfo();

    const toggleExpand = () => {
        setExpanded(!expanded());
    }

    return (
        <span 
            class="text-sm font-mono bg-gray-200 dark:bg-gray-700 px-1 py-0.5 mt-2 rounded cursor-pointer" 
            onClick={toggleExpand}
        >
            {expanded() ? (
                <>
                    <div>Working Dir: {repoInfo().workingDir}</div>
                    <div>URL: {repoInfo().url}</div>
                    <div>Branch: {repoInfo().branch}</div>
                    <div>Name: {repoInfo().name}</div>
                    <div>Description: {repoInfo().description}</div>
                </>
            ) : (
                <>
                    {repoInfo().name} {repoInfo().branch}
                </>
            )}
        </span>
    );
};

export default RepoInfo;

```

./src/frontend/service/fetchers/fetchRepoInfo.js:
```
import { getBaseUrl } from '../../getBaseUrl';

const fetchRepoInfo = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/repoinfo`);
  const data = await response.json();
  return data;
};

export default fetchRepoInfo;

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Repo info now contains tags array. List among details. Say not available if missing


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


Do NOT write any text outside the script!

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


