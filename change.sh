#!/bin/sh
set -e
goal="Respond with JSON with output field"
echo "Plan:"
echo "1. Modify executeHandler.js to return json with output field"
cat <<EOF > src/backend/handlers/executeHandler.js
import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';
import { extractCode } from '../../execute/extractCode.js';

async function executeHandler(req, res) {
  let code = req.body.change;

  // Check if code starts with shebang
  if (!code.startsWith("#!")) {
    code = extractCode(code);
  }
  
  await executeAndForwardOutput(code, (code, output) => {
    res.json({ output });
  });
}

export { executeHandler };

EOF
echo "\033[32mDone: $goal\033[0m\n"
