#!/bin/sh
set -e
goal="Introduce a ProofInput beside CommitMessageInput"
echo "Plan:"
echo "1. Create the ProofInput component."
echo "2. Update ChangeFinalization.jsx to include and style ProofInput and CommitMessageInput."

# 1. Create the ProofInput component
cat > ./src/frontend/components/ProofInput.jsx << 'EOF'
import { createSignal } from 'solid-js';

const ProofInput = () => {
  const [proof, setProof] = createSignal('');

  const handleChange = (e) => {
    setProof(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Proof..." value={proof()} onInput={handleChange} />
  );
};

export default ProofInput;
EOF

# 2. Update ChangeFinalization.jsx
cat > ./src/frontend/components/ChangeFinalization.jsx << 'EOF'
import CommitMessageInput from './CommitMessageInput';
import ProofInput from './ProofInput';
import CommitButton from './CommitButton';
import RollbackButton from './RollbackButton';

const ChangeFinalization = () => {
  return (
    <>
      <div className="flex w-full space-x-4">
        <CommitMessageInput className="flex-grow w-7/10" />
        <ProofInput className="w-3/10" />
      </div>
      <div className="flex w-full mt-1 space-x-4">
        <RollbackButton />
        <CommitButton />
      </div>
    </>
  );
};

export default ChangeFinalization;
EOF

echo "\033[32mDone: $goal\033[0m\n"