#!/bin/sh
set -e
goal="Implement debug feature in generateHandler"
echo "Plan:"
echo "1. Create src/config/isDebug.js"
echo "2. Modify src/backend/handlers/generateHandler.js"

# Create src/config/isDebug.js
cat > ./src/config/isDebug.js << 'EOF'
import { argv } from 'process';

export function isDebug() {
  const hasDebugArg = argv.includes('--debug');
  const hasDebugEnv = process.env.JUNIOR_DEBUG === 'true';
  return hasDebugArg || hasDebugEnv;
}
EOF

# Modify src/backend/handlers/generateHandler.js
cat > ./src/backend/handlers/generateHandler.js << 'EOF'
import generatePrompt from '../../prompt/generatePrompt.js';
import isRepoClean from '../../git/isRepoClean.js';
import { isDebug } from '../../config/isDebug.js';

export const generateHandler = async (req, res) => {
  try {
    const debugEnabled = isDebug();

    if (!debugEnabled && !await isRepoClean()) {
      throw new Error("Directory is not clean. Please commit or stash changes and try again. Use --debug to bypass this check.");
    } else if (debugEnabled && !await isRepoClean()) {
      console.warn('\x1b[33m%s\x1b[0m', 'Warning: Debug mode enabled and the directory is not clean.');
    }

    const { notes, systemPrompt } = req.body;
    const { prompt } = await generatePrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    res.status(500).json({ error: error.message });
  }
};
EOF

echo "\033[32mDone: $goal\033[0m\n"