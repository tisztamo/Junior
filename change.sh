#!/bin/sh
set -e
goal="Move and rename monitorChangeSignal.js"
echo "Plan:"
echo "1. Move monitorChangeSignal.js from src/frontend/service/ to src/frontend/stores/ and rename it to monitorChange.js."
echo "2. Update the import path in CommitMessageInput.jsx to reflect the new location and name of monitorChange.js."
echo "3. Ensure no other parts of the code depend on the old path of monitorChangeSignal.js."

# Move and rename monitorChangeSignal.js to monitorChange.js
mv src/frontend/service/monitorChangeSignal.js src/frontend/stores/monitorChange.js

# Update CommitMessageInput.jsx with the new import path for monitorChange.js
cat << 'EOF' > src/frontend/components/CommitMessageInput.jsx
import { onCleanup } from 'solid-js';
import { commitMessage, setCommitMessage } from '../stores/commitMessage';
import monitorChangeSignal from '../stores/monitorChange';

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

# Update monitorChange.js with the new content
cat << 'EOF' > src/frontend/stores/monitorChange.js
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

echo "\033[32mDone: $goal\033[0m\n"
