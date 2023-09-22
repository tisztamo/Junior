#!/bin/sh
set -e

goal="Integrate clearProof with clearState functionality"
echo "Plan:"
echo "1. Modify clearState.js to also clear the proof model."
echo "2. Ensure all constraints are met."

# Modify clearState.js
cat > ./src/frontend/service/clearState.js << 'EOF'
import { setChange } from '../model/change';
import { setExecutionResult } from '../model/executionResult';
import { setCommitMessage } from '../model/commitMessage';
import { setPrompt } from '../model/prompt';
import { setGitStatus } from '../model/gitStatus';
import { setProof } from '../model/proofModel';

const clearState = () => {
  setChange('');
  setExecutionResult('');
  setCommitMessage('');
  setPrompt('');
  setGitStatus('');
  setProof('');
};

export default clearState;
EOF

echo "\033[32mDone: $goal\033[0m\n"