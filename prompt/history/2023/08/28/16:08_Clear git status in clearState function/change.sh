#!/bin/sh
set -e
goal="Clear git status in clearState function"
echo "Plan:"
echo "1. Update clearState.js to include setGitStatus function."
echo "2. Modify the clearState function to clear git status."

cat > src/frontend/service/clearState.js << 'EOF'
import { setChange } from '../model/change';
import { setExecutionResult } from '../model/executionResult';
import { setCommitMessage } from '../model/commitMessage';
import { setPrompt } from '../model/prompt';
import { setGitStatus } from '../model/gitStatus';

const clearState = () => {
  setChange('');
  setExecutionResult('');
  setCommitMessage('');
  setPrompt('');
  setGitStatus('');
};

export default clearState;
EOF

echo "\033[32mDone: $goal\033[0m\n"