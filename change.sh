#!/bin/sh
set -e
goal="Add console.warn to log the error"
echo "Plan:"
echo "1. Modify generateHandler.js to include a console.warn statement for error logging."

cat > src/backend/handlers/generateHandler.js << 'EOF'
import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  try {
    const { notes, systemPrompt } = req.body;
    const { prompt } = await processPrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    res.json({ error: error.message });
  }
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
