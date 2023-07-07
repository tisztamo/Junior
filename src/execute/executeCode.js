#!/usr/bin/env node

import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";
import { exec } from 'child_process';

const executeCode = async (cod, last_command_result, parent_message_id, rl) => {
  rl.question('\x1b[1mEXECUTE? [y/n]\x1b[0m ', async (answer) => {
    console.log("");
    if (answer.toLowerCase() === 'y' || answer === "") {
      exec(cod, (error, stdout, stderr) => {
        if (error) {
          console.error(`${error.message}`);
          last_command_result = "Command failed. Output:\n" + error.message + "\n";
        } else {
          if (stdout.length > 0) {
            console.log(`${stdout}`);
          }
          if (stderr.length > 0) {
            console.log(`${stderr}`);
          }
          last_command_result = "Command executed. Output:\n" + stdout + "\n" + stderr + "\n";
        }
        startInteractiveSession(last_command_result, parent_message_id, rl)
      });
    } else {
      last_command_result = "Command skipped.\n";
      startInteractiveSession(last_command_result, parent_message_id, rl);
    }
  });
}

export { executeCode };
