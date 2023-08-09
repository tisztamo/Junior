import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';
import { extractCode } from '../../execute/extractCode.js';

async function executeHandler(req, res) {
  let code = req.body.change;

  // Check if code starts with shebang
  if (!code.startsWith("#!")) {
    code = extractCode(code);
  }
  
  const output = await executeAndForwardOutput(code);
  res.json(output);
}

export { executeHandler };
