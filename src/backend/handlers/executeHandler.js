import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';
import { extractCode } from '../../execute/extractCode.js';

function executeHandler(req, res) {
  const code = extractCode(req.body.change);
  executeAndForwardOutput(code, (result, output) => {
    res.json({ result, output });
  });
}

export { executeHandler };
