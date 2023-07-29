import { writeFile } from 'fs/promises';
import { spawn } from 'child_process';
import { makeExecutable } from './makeExecutable.js';
import {promisify} from 'util';

const writeFileAsync = promisify(writeFile);
const makeExecutableAsync = promisify(makeExecutable)

async function executeAndForwardOutput(code, next) {
  try {
    if (!code.startsWith('#!')) {
      throw new Error('Code does not start with a shebang');
    }
    
    await writeFileAsync('./change.sh', code);
    await makeExecutableAsync('./change.sh');
    
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

    // child.on('close', (code) => {
    //   next(code, commandOutput);
    // });
    child.on('close', (code) => {
      res.status(200).json({ code, output: commandOutput });
    });
  } catch (err) {
    // console.log(err);
    res.status(500).json({ error: err.message });
  }
}

export { executeAndForwardOutput };
