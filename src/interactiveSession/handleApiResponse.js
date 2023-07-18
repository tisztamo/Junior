import { executeCode } from '../execute/executeCode.js';
import { extractCode } from '../execute/extractCode.js';
import { startInteractiveSession } from './startInteractiveSession.js';

const handleApiResponse = (msg, rl, api) => {
  const cod = extractCode(msg);
  if (cod) {
    executeCode(cod, rl, api);
  } else {
    startInteractiveSession(rl, api);
  }
}

export { handleApiResponse };
