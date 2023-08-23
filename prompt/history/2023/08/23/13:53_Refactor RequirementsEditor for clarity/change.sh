#!/bin/sh
set -e
goal="Refactor RequirementsEditor for clarity"
echo "Plan:"
echo "1. Introduce a signal for requirements in the model to handle reactivity."
echo "2. Modify RequirementsEditor.jsx to directly use the new signal without the extra variable."

# Step 1: Create a new model for requirements using a signal (remains unchanged)
cat > ./src/frontend/model/requirements.js << 'EOF'
import { createSignal } from 'solid-js';

export const [requirements, setRequirements] = createSignal('');
EOF

# Step 2: Modify RequirementsEditor.jsx to use the newly created signal and eliminate the extra variable
cat > ./src/frontend/components/RequirementsEditor.jsx << 'EOF'
import { createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor } from '../model/promptDescriptor';
import { requirements, setRequirements } from '../model/requirements';

const RequirementsEditor = () => {
  const handleRequirementsChange = async (e) => {
    setRequirements(e.target.value);
    await postDescriptor({ requirements: e.target.value });
  };

  createEffect(() => {
    const currentRequirements = promptDescriptor().requirements || '';
    if (currentRequirements !== requirements()) {
      setRequirements(currentRequirements);
    }
  });

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded border border-border mt-4">
      <textarea
        class="w-full bg-emphasize text-emphasize text-lg"
        placeholder="Enter your requirements..."
        value={requirements()}
        onInput={e => handleRequirementsChange(e)}
      />
    </div>
  );
};

export default RequirementsEditor;
EOF

echo "\033[32mDone: $goal\033[0m\n"