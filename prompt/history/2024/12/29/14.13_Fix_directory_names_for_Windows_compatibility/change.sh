#!/bin/sh
set -e

goal="Fix directory names for Windows compatibility"
echo "Plan:"
echo "1. Adjust saveAuditTrail to use a dot in time format."
echo "2. Create fixPromptPathsForWindows.js to rename directories recursively."
echo "3. Execute fixPromptPathsForWindows.js at the end."

# Step 1: Update saveAuditTrail.js
cat > src/execute/saveAuditTrail.js << 'EOF'
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
    const time = String(date.getHours()).padStart(2, '0') + '.' + String(date.getMinutes()).padStart(2, '0');

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
EOF

echo "Updated: saveAuditTrail.js with dot in time format."

# Step 2: Create fixPromptPathsForWindows.js
cat > scripts/fixPromptPathsForWindows.js << 'EOF'
import { readdir, rename } from 'fs/promises';
import { join } from 'path';

async function fixPaths(dir) {
    const entries = await readdir(dir, { withFileTypes: true });

    for (const entry of entries) {
        const oldPath = join(dir, entry.name);

        if (entry.isDirectory()) {
            const newName = entry.name.replace(/:/g, '.');
            const newPath = join(dir, newName);

            if (newName !== entry.name) {
                await rename(oldPath, newPath);
                console.log(`Renamed: ${oldPath} -> ${newPath}`);
            }

            await fixPaths(newPath);
        }
    }
}

(async function () {
    try {
        await fixPaths('./prompt/history');
        console.log('Directory paths fixed for Windows compatibility.');
    } catch (err) {
        console.error('Error fixing paths:', err);
        process.exit(1);
    }
})();
EOF

echo "Created: scripts/fixPromptPathsForWindows.js"

# Step 3: Execute fixPromptPathsForWindows.js
node scripts/fixPromptPathsForWindows.js

echo "\033[32mDone: $goal\033[0m"
