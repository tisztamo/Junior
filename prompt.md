You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

# Working set

src/execute/saveAuditTrail.js:
```
import { writeFile, mkdir } from 'fs/promises';

async function saveAuditTrail(code) {
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
        writeFile(`${auditTrailDir}prompt.yaml`, await fs.promises.readFile('./prompt.yaml', 'utf-8')),
        writeFile(`${auditTrailDir}prompt.md`, await fs.promises.readFile('./prompt.md', 'utf-8')),
        writeFile(`${auditTrailDir}change.sh`, code),
    ]);

    console.log(`Audit trail saved to ${auditTrailDir}`);
}

export { saveAuditTrail };

```


# Task

Fix the following issue!

ReferenceError: fs is not defined
  at saveAuditTrail (file:///Users/ko/projects-new/Junior/src/execute/saveAuditTrail.js:21:56)
  at async executeAndForwardOutput (file:///Users/ko/projects-new/Junior/src/execute/executeAndForwardOutput.js:12:9)
  at async executeHandler (file:///Users/ko/projects-new/Junior/src/backend/handlers/executeHandler.js:12:3)



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs* and Tailwind, edit .jsx file accordingly!


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

