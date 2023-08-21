#!/bin/sh
set -e
goal="Implement Audit Trail"
echo "Plan:"
echo "1. Gitignore 'prompt.yaml', 'prompt.md', and 'change.sh'."
echo "2. Extract audit trail logic into 'saveAuditTrail.js'."
echo "3. Modify 'executeAndForwardOutput.js' to use the new 'saveAuditTrail' function."
echo "4. Before executing change, create a directory for audit trail based on the current date and goal."
echo "5. Copy the gitignored files to the new directory."

# Step 1: Update .gitignore
cat <<EOF > .gitignore
secret.sh
node_modules/
tmp/
prompt.yaml
prompt.md
change.sh
EOF

# Step 2: Extract audit trail logic into saveAuditTrail.js
cat <<EOF > src/execute/saveAuditTrail.js
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

    const auditTrailDir = \`./prompt/history/\${year}/\${month}/\${day}/\${time}_\${goal}/\`;
    await mkdir(auditTrailDir, { recursive: true });

    // Copy files to the new directory
    await Promise.all([
        writeFile(\`\${auditTrailDir}prompt.yaml\`, await fs.promises.readFile('./prompt.yaml', 'utf-8')),
        writeFile(\`\${auditTrailDir}prompt.md\`, await fs.promises.readFile('./prompt.md', 'utf-8')),
        writeFile(\`\${auditTrailDir}change.sh\`, code),
    ]);

    console.log(\`Audit trail saved to \${auditTrailDir}\`);
}

export { saveAuditTrail };
EOF

# Step 3: Modify executeAndForwardOutput.js to use saveAuditTrail
cat <<EOF > src/execute/executeAndForwardOutput.js
import { writeFile } from 'fs/promises';
import { spawn } from 'child_process';
import { makeExecutable } from './makeExecutable.js';
import { saveAuditTrail } from './saveAuditTrail.js';

async function executeAndForwardOutput(code, next) {
    try {
        if (code == null || !code.startsWith('#!')) {
            throw new Error('Code does not start with a shebang');
        }
        
        await saveAuditTrail(code);

        await writeFile('./change.sh', code);
        await makeExecutable('./change.sh');
        
        const child = spawn('./change.sh', [], { shell: true });
        let commandOutput = '';

        child.stdout.on('data', (data) => {
            console.log(\`\${data}\`);
            commandOutput += data;
        });

        child.stderr.on('data', (data) => {
            console.error(\`\${data}\`);
            commandOutput += data;
        });

        child.on('close', (code) => {
            if (next && typeof next === 'function') {
                next(code, commandOutput);
            }
        });
    } catch (err) {
        console.log(err);
    }
}

export { executeAndForwardOutput };
EOF

echo "\033[32mDone: $goal\033[0m\n"