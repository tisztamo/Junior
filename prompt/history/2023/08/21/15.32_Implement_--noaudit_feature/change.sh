#!/bin/sh
set -e
goal="Implement --noaudit feature"
echo "Plan:"
echo "1. Update AuditTrailConfig.js to throw a warning only once per execution using a module-global variable."
echo "2. Modify saveAuditTrail.js to use the updated AuditTrailConfig."

# Step 1: Update AuditTrailConfig.js to warn only once per execution
cat <<EOF > ./src/execute/AuditTrailConfig.js
let warned = false;

export default function AuditTrailConfig() {
    const enabled = !process.argv.includes('--noaudit');
    if (!enabled && !warned) {
        console.warn('Warning: Audit trail is disabled.');
        warned = true;
    }
    return { enabled };
}
EOF

# Step 2: Modify saveAuditTrail.js to use the updated AuditTrailConfig
cat <<EOF > ./src/execute/saveAuditTrail.js
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

    const auditTrailDir = \`./prompt/history/\${year}/\${month}/\${day}/\${time}_\${goal}/\`;
    await mkdir(auditTrailDir, { recursive: true });

    // Copy files to the new directory
    await Promise.all([
        writeFile(\`\${auditTrailDir}prompt.yaml\`, await readFile('./prompt.yaml', 'utf-8')),
        writeFile(\`\${auditTrailDir}prompt.md\`, await readFile('./prompt.md', 'utf-8')),
        writeFile(\`\${auditTrailDir}change.sh\`, code),
    ]);

    console.log(\`Audit trail saved to \${auditTrailDir}\`);
}

export { saveAuditTrail };
EOF

echo "\033[32mDone: $goal\033[0m\n"