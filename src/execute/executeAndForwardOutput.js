import { spawn } from 'child_process';
import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";

function executeAndForwardOutput(code, last_command_result, parent_message_id, rl) {
  const child = spawn(code, { shell: true });

  child.stdout.on('data', (data) => {
    console.log(`${data}`);
    last_command_result += data;
  });

  child.stderr.on('data', (data) => {
    console.error(`${data}`);
    last_command_result += data;
  });

  child.on('close', (code) => {
    if (code !== 0) {
      console.log(`child process exited with code ${code}`);
      last_command_result = "Command failed. Output:\n" + last_command_result;
    } else {
      last_command_result = "Command executed. Output:\n" + last_command_result;
    }
    startInteractiveSession(last_command_result, parent_message_id, rl)
  });
}

export { executeAndForwardOutput };
