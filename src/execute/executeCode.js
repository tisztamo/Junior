import { confirmExecution } from './confirmExecution.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';
import { startInteractiveSession } from "../interactiveSession/startInteractiveSession.js";

const executeCode = async (code) => {
  confirmExecution(code, () => executeAndForwardOutput(code, startInteractiveSession));
}

export { executeCode };
