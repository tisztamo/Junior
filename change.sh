#!/bin/sh
set -e
goal="Implement monitoring in CommitMessageInput"
echo "Plan:"
echo "1. Modify monitorChangeSignal.js to add a flag indicating whether monitoring is already running."
echo "2. Modify CommitMessageInput.jsx to start monitoring change signal when mounting, without running it if it is already running."

# Step 1: Modify monitorChangeSignal.js to add a flag indicating whether monitoring is already running
cat << 'EOF' > src/frontend/service/monitorChangeSignal.js
import { createEffect } from 'solid-js';
import { change } from '../stores/change';
import { setCommitMessage } from '../stores/commitMessage';

let monitoring = false;

const monitorChangeSignal = () => {
  if (monitoring) return;

  monitoring = true;

  createEffect(() => {
    const newChangeContent = change();
    const goalLineMatch = newChangeContent.match(/goal="(.+?)"/);
    
    if (goalLineMatch) {
      const goalValue = goalLineMatch[1];
      
      setCommitMessage(goalValue);
    }
  });
};

export default monitorChangeSignal;
EOF

# Step 2: Modify CommitMessageInput.jsx to start monitoring change signal when mounting, without running it if it is already running
cat << 'EOF' > src/frontend/components/CommitMessageInput.jsx
import { onCleanup } from 'solid-js';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import monitorChangeSignal from '../service/monitorChangeSignal';

const CommitMessageInput = (props) => {
  // Start monitoring when mounting
  monitorChangeSignal();

  const handleChange = (e) => {
    setCommitMessage(e.target.value);
  };

  return (
    <input type="text" className="w-64 px-4 py-2 border rounded" placeholder="Commit message..." value={commitMessage()} onInput={handleChange} />
  );
};

export default CommitMessageInput;
EOF

echo "\033[32mDone: $goal\033[0m\n"
