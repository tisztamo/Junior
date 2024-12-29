You are a senior software developer, you code like Donald Knuth.

# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Instead of a colon, use dot character between hours and minutes in the directory name.

Also create scripts/fixPromptPathsForWindows.js which runs through the dir prompt/history recursively and renames all the directories that contain a colon in the name. The script will run on unix, to fix the directory structure and allow checkout on windows.

Also tun the newly created script at the end.

updateConfigList is an example script.




## Project Specifics

- Every js file should *only export a single function or signal*! eg.: in createGitRepo.js: export function createGitRepo ( ....
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx files accordingly!

Write concise, self-documenting and idiomatic ES6 code!

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Avoid using sed. Always heredoc full files.

OS: Debian


Installed tools: npm, jq




EXAMPLE START
```sh
#!/bin/sh
set -e
goal=[Task description, max 9 words]
echo "Plan:"
echo "1. [...]"

# Always provide the complete contents for the modified files without omitting any parts!
cat > x.js << EOF
  let i = 1
  console.log(\`i: \${i}\`)
EOF
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

# Working set

scripts/updateConfigList.js:
```
import { join } from 'path';
import { promises as fs } from 'fs';
import { searchFiles } from '../src/command/updateConfigList/searchFiles.js';

const BASE_DIR = '.';
const SRC_DIR = join(BASE_DIR, 'src');
const OUTPUT_FILE = join(BASE_DIR, 'docs/design/config-file-list.yaml');

async function findConfigAccessFiles() {
  const files = await searchFiles(SRC_DIR);

  const accessedFiles = files.filter(file => 
    file.content.includes('process.env') || file.content.includes('process.argv')
  );

  return accessedFiles.map(file => file.path);
}

async function main() {
  const fileList = await findConfigAccessFiles();
  
  const yamlContent = `envAndCli:\n${fileList.map(file => `  - ${file}`).join('\n')}`;
  await fs.writeFile(OUTPUT_FILE, yamlContent, 'utf8');
}

main();

```
src/execute/saveAuditTrail.js:
```
import { writeFile, mkdir, readFile } from 'fs/promises';
import AuditTrailConfig from './AuditTrailConfig.js';

async function saveAuditTrail(code) {
    const { enabled } = AuditTrailConfig();

    if (!enabled) {
        return;
    }

    const goalMatch = code.match(/goal="([^"]+)"/);
    if (!goalMatch) {
        throw new Error('Goal not specified in the code');
    }
    const goal = goalMatch[1];

    const date = new Date();
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const time = String(date.getHours()).padStart(2, '0') + ':' + String(date.getMinutes()).padStart(2, '0');

    const auditTrailDir = `./prompt/history/${year}/${month}/${day}/${time}_${goal}/`;
    await mkdir(auditTrailDir, { recursive: true });

    // Copy files to the new directory
    await Promise.all([
        writeFile(`${auditTrailDir}prompt.yaml`, await readFile('./prompt.yaml', 'utf-8')),
        writeFile(`${auditTrailDir}prompt.md`, await readFile('./prompt.md', 'utf-8')),
        writeFile(`${auditTrailDir}change.sh`, code),
    ]);

    console.log(`Audit trail saved to ${auditTrailDir}. Use --noaudit to disable the audit trail.`);
}

export { saveAuditTrail };

```