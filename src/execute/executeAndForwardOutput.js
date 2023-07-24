import { spawn } from 'child_process';
import { rl } from '../config.js';

function executeAndForwardOutput(code, next) {
  const child = spawn(code, { shell: true });
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
    next(code, commandOutput);
  });
}

export { executeAndForwardOutput };
