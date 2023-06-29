import { executeCode } from '../execute/executeCode.js';
import { extractCode } from '../execute/extractCode.js';
import { startInteractiveSession } from './startInteractiveSession.js';

const handleApiResponse = (msg, last_command_result, parent_message_id, rl, api) => {
  const cod = extractCode(msg);
  if (cod) {
    executeCode(cod, last_command_result, parent_message_id, rl, api);
  } else {
    last_command_result = "";
    startInteractiveSession(last_command_result, parent_message_id, rl, api);
  }
}

export { handleApiResponse };
