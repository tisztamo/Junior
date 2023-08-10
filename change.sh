#!/bin/sh
set -e
goal="Catch errors and put in error field"
echo "Plan:"
echo "1. Edit generateHandler.js to catch and handle errors"
echo "2. Update the function to return the error in the response if an exception occurs"

cat > src/backend/handlers/generateHandler.js << 'EOF'
import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  try {
    const { notes, systemPrompt } = req.body;
    const { prompt } = await processPrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    res.json({ error: error.message });
  }
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
