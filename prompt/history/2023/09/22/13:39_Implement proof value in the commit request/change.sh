#!/bin/sh
set -e
goal="Implement proof value in the commit request"
echo "Plan:"
echo "1. Move the proof signal to its own model file."
echo "2. Modify the postCommit service to accept message and proof."
echo "3. Change handleCommitService to use the new signature and include the proof."

# Move proof signal to its own model file
cat > ./src/frontend/model/proofModel.js << 'EOF'
import { createSignal } from 'solid-js';

const [proof, setProof] = createSignal('');

export { proof, setProof };
EOF

# Modify the ProofInput.jsx to use the new model
cat > ./src/frontend/components/ProofInput.jsx << 'EOF'
import { createSignal } from 'solid-js';
import { proof, setProof } from '../model/proofModel';

const ProofInput = () => {
  const handleChange = (e) => {
    setProof(e.target.value);
  };

  return (
    <input type="text" className="w-full px-4 py-2 border rounded bg-emphasize text-emphasize border-border" placeholder="Proof..." value={proof()} onInput={handleChange} />
  );
};

export default ProofInput;
EOF

# Modify postCommit service to include proof
cat > ./src/frontend/service/postCommit.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';

const postCommit = async (message, proof) => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/commit`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message, proof }),
  });

  const data = await response.json();

  return data;
};

export default postCommit;
EOF

# Modify handleCommitService to use the new postCommit signature and include proof from the model
cat > ./src/frontend/service/lifecycle/handleCommitService.js << 'EOF'
import postCommit from '../postCommit';
import postDescriptor from '../postDescriptor';
import { commitMessage } from '../../model/commitMessage';
import { proof } from '../../model/proofModel';
import { fetchGitStatus } from '../fetchGitStatus';
import clearState from '../clearState';

export default async function handleCommitService() {
  const response = await postCommit(commitMessage(), proof());
  console.log(response.message);
    
  await postDescriptor({ requirements: '' });
    
  const status = await fetchGitStatus();
  console.log(status);
  clearState();
}
EOF

echo "\033[32mDone: $goal\033[0m\n"