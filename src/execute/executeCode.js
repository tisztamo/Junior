#!/usr/bin/env node

import { confirmAndWriteCode } from './confirmAndWriteCode.js';
import { executeAndForwardOutput } from './executeAndForwardOutput.js';

const executeCode = async (code, last_command_result, parent_message_id, rl) => {
  confirmAndWriteCode(code, rl, () => executeAndForwardOutput(code, last_command_result, parent_message_id, rl));
}

export { executeCode };
