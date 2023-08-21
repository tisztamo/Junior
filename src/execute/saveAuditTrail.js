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

    console.log(`Audit trail saved to ${auditTrailDir}`);
}

export { saveAuditTrail };
