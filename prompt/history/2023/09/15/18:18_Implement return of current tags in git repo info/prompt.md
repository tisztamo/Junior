You are AI Junior, you code like Donald Knuth.
# Working set

./src/backend/handlers/git/gitRepoInfoHandler.js:
```
import getRepoInfo from '../../../git/getRepoInfo.js';

export default async function gitRepoInfoHandler(req, res) {
    try {
        const repoInfo = await getRepoInfo();
        res.status(200).send(repoInfo);
    } catch (error) {
        res.status(500).send({ message: 'Error fetching repo info', error });
    }
}

```

./src/git/getRepoInfo.js:
```
import simpleGit from 'simple-git';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const git = simpleGit();

export default async function getRepoInfo() {
    const remote = await git.getRemotes(true);
    const currentBranch = await git.revparse(['--abbrev-ref', 'HEAD']);
    const rootDir = await git.revparse(['--show-toplevel']);
    const packagePath = path.resolve(rootDir, 'package.json');

    let packageJSON = {};
    try {
        packageJSON = JSON.parse(fs.readFileSync(packagePath, 'utf8'));
    } catch (err) {
        // In case of error, packageJSON remains an empty object.
    }
    
    const workingDir = path.resolve(__dirname, '../../');

    return {
        url: remote[0]?.refs?.fetch || '',
        branch: currentBranch,
        name: packageJSON.name || '',
        description: packageJSON.description || '',
        workingDir: workingDir
    };
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Also return current tags


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


