import { executeCode } from '../execute/executeCode.js';
import { extractCode } from '../execute/extractCode.js';
import { startInteractiveSession } from './startInteractiveSession.js';

const handleApiResponse = (msg) => {
  const cod = extractCode(msg);
  if (cod) {
    executeCode(cod);
  } else {
    startInteractiveSession();
  }
}

export { handleApiResponse };
