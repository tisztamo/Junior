import { confirmAndWriteCode } from './confirmAndWriteCode.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

const executeCode = async (code) => {
  confirmAndWriteCode(code, () => executeAndForwardOutput(code));
}

export { executeCode };
