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
            console.log(`${data}`);
            commandOutput += data;
        });

        child.stderr.on('data', (data) => {
            console.error(`${data}`);
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
