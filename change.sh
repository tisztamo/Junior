#!/bin/sh
set -e
goal="Use loadPromptDescriptor in servePromptDescriptor"
echo "Plan:"
echo "1. Import loadPromptDescriptor in servePromptDescriptor.js"
echo "2. Use loadPromptDescriptor instead of readFile in the servePromptDescriptor function"

cat >./src/backend/handlers/servePromptDescriptor.js <<'EOF'
import { loadPromptDescriptor } from '../../prompt/loadPromptDescriptor.js';

export const servePromptDescriptor = async (req, res) => {
  const file = await loadPromptDescriptor();
  res.send(file);
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
