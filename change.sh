#!/bin/sh
set -e
goal="Implement shebang code execution"
echo "Plan:"
echo "1. Update the executeHandler function to check for shebang and decide on its processing."
echo "2. Refactor the 'executeHandler' to match the project specifics."

# Step 1: Update the executeHandler function
cat > src/backend/handlers/executeHandler.js << 'EOF'
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
EOF

echo "\033[32mDone: $goal\033[0m\n"
