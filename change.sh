#!/bin/sh
set -e
goal="Refactor code, rename function, remove import"
echo "Plan:"
echo "1. Rename monitorChangeSignal to monitorChange and add a comment in src/frontend/stores/monitorChange.js"
echo "2. Update the function name in src/frontend/components/CommitMessageInput.jsx and remove unnecessary import"
echo "3. Save changes to the corresponding files"

# Step 1
cat > src/frontend/stores/monitorChange.js << 'EOF'
import { createEffect } from 'solid-js';
import { change } from '../stores/change';
import { setCommitMessage } from '../stores/commitMessage';

// The monitorChange function starts monitoring the change store,
// and if a goal is found, it sets the commit message accordingly.
let monitoring = false;

const monitorChange = () => {
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

export default monitorChange;
EOF

# Step 2
cat > src/frontend/components/CommitMessageInput.jsx << 'EOF'
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import monitorChange from '../stores/monitorChange';

const CommitMessageInput = (props) => {
  // Start monitoring when mounting
  monitorChange();

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
