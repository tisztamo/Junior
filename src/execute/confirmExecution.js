import { rl } from '../config.js';

function confirmExecution(code, next) {
  rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', (answer) => {
    if (answer.toLowerCase() === 'y') {
      console.log("\x1b[33mExecuting...\x1b[0m");
      next();
    } else {
      console.log("\x1b[33mNot executing.\x1b[0m");
    }
  });
}

export { confirmExecution };
