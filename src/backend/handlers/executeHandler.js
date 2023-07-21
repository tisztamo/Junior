import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';

function executeHandler(req, res) {
  executeAndForwardOutput(req.body.change, (result) => {
    res.json({ result });
  });
}

export { executeHandler };
