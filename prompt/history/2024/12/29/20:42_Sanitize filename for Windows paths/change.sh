#!/bin/sh
set -e

goal="Sanitize filename for Windows paths"
echo "Plan:"
echo "1. Create a sanitizeFilename.js file to sanitize filenames."
echo "2. Implement the sanitizeFilename function to replace disallowed characters with underscores."
echo "3. Export the function as per the project's standards (single function per file)."
echo "4. Test the function to ensure it behaves as expected."
echo "5. Integrate it into saveAuditTrail.js if required."

# Ensure the utils directory exists
mkdir -p src/utils

# Step 1: Create sanitizeFilename.js
cat > src/utils/sanitizeFilename.js << 'EOF'
/**
 * Sanitize a filename or directory name to be safe for Windows paths.
 * Replaces any disallowed characters with underscores (_).
 *
 * @param {string} name - The filename or directory name to sanitize.
 * @returns {string} - The sanitized name.
 */
export function sanitizeFilename(name) {
    if (typeof name !== 'string') {
        throw new TypeError('Filename must be a string');
    }

    // Define a regex for characters not allowed in Windows filenames
    const disallowedChars = /[<>:"/\\|?*]/g;
    const sanitized = name.replace(disallowedChars, '_');

    // Ensure the name is not empty or only underscores
    return sanitized || '_';
}
EOF

echo "Created sanitizeFilename.js"

# Step 2: Update saveAuditTrail.js to use sanitizeFilename if needed
mkdir -p src/execute
cat > src/execute/saveAuditTrail.js << 'EOF'
import { writeFile, mkdir, readFile } from 'fs/promises';
import AuditTrailConfig from './AuditTrailConfig.js';
import { sanitizeFilename } from '../utils/sanitizeFilename.js';

async function saveAuditTrail(code) {
    const { enabled } = AuditTrailConfig();

    if (!enabled) {
        return;
    }

    const goalMatch = code.match(/goal="([^"]+)"/);
    if (!goalMatch) {
        throw new Error('Goal not specified in the code');
    }
    const goal = sanitizeFilename(goalMatch[1]);

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

echo "Updated saveAuditTrail.js to use sanitizeFilename."

echo "\033[32mDone: $goal\033[0m\n"
