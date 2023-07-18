import { writeFile } from 'fs';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

function confirmAndWriteCode(code, rl, execute) {
  rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', (answer) => {
    console.log("");
    if (answer.toLowerCase() === 'y' || answer === "") {
      writeFile('./change.sh', code, (err) => {
        if (err) {
          console.error(err.message);
          return;
        }
        execute();
      });
    }
  });
}

export { confirmAndWriteCode };
