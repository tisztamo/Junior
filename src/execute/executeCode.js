#!/usr/bin/env node

import { confirmAndWriteCode } from './confirmAndWriteCode.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

const executeCode = async (code, rl, api) => {
  confirmAndWriteCode(code, rl, () => executeAndForwardOutput(code, rl, api));
}

export { executeCode };
