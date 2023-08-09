#!/bin/sh
set -e
goal="Extract code from change before executing"
echo "Plan:"
echo "1. Import the existing extractCode function in src/backend/handlers/executeHandler.js."
echo "2. Update the executeHandler to call the extractCode function before executing the change."

# Step 1: Import the existing extractCode function and update the executeHandler
cat > src/backend/handlers/executeHandler.js <<EOF
import { executeAndForwardOutput } from '../../execute/executeAndForwardOutput.js';
import { extractCode } from '../../execute/extractCode.js';

function executeHandler(req, res) {
  const code = extractCode(req.body.change);
  executeAndForwardOutput(code, (result, output) => {
    res.json({ result, output });
  });
}

export { executeHandler };
EOF

echo "\033[32mDone: $goal\033[0m\n"
