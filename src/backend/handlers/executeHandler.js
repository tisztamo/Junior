import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';

function executeHandler(req, res) {
  executeAndForwardOutput(req.body.change, (result, output) => {
    res.json({ result, output });
  });
}

export { executeHandler };
