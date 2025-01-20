import { writeFile } from 'fs/promises';
import { spawn } from 'child_process';
import { makeExecutable } from './makeExecutable.js';
import { saveAuditTrail } from './saveAuditTrail.js';

async function executeAndForwardOutput(code, next) {
    try {
        if (!code || !code.startsWith('#!')) {
            throw new Error('Code does not start with a shebang');
        }

        await saveAuditTrail(code);

        await writeFile('./change.sh', code);
        await makeExecutable('./change.sh');

        let command;
        let args = [];
        let spawnOptions = {};

        if (process.platform === 'win32') {
            // On Windows, explicitly call Bash
            command = 'bash.exe';
            args = ['./change.sh'];
            spawnOptions.shell = false; 
        } else {
            // On other platforms, just execute the script with shell
            command = './change.sh';
            spawnOptions.shell = true;
        }

        const child = spawn(command, args, spawnOptions);

        let commandOutput = '';

        child.stdout.on('data', (data) => {
            console.log(`${data}`);
            commandOutput += data;
        });

        child.stderr.on('data', (data) => {
            console.error(`${data}`);
            commandOutput += data;
        });

        child.on('close', (exitCode) => {
            if (next && typeof next === 'function') {
                next(exitCode, commandOutput);
            }
        });
    } catch (err) {
        console.log(err);
    }
}

export { executeAndForwardOutput };
