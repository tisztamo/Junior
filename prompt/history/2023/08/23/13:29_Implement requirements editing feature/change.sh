#!/bin/sh
set -e
goal="Implement requirements editing feature"
echo "Plan:"
echo "1. Create a new component named 'RequirementsEditor'."
echo "2. Implement the functionality to update the requirements section upon textarea changes."
echo "3. Integrate the new component into the 'PromptCreation' component."

# Step 1: Create a new component named 'RequirementsEditor'.
cat > src/frontend/components/RequirementsEditor.jsx << 'EOF'
import { createSignal } from 'solid-js';
import postDescriptor from '../service/postDescriptor';

const RequirementsEditor = () => {
  const [requirements, setRequirements] = createSignal('');

  const handleRequirementsChange = async (e) => {
    setRequirements(e.target.value);
    await postDescriptor({ requirements: e.target.value });
  };

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded border border-border mt-4">
      <label class="text-lg mr-2">Requirements:</label>
      <textarea
        class="w-full bg-emphasize text-emphasize text-lg"
        value={requirements()}
        onInput={e => handleRequirementsChange(e)}
      />
    </div>
  );
};

export default RequirementsEditor;
EOF

# Step 2: Integrate the new component into the 'PromptCreation' component.
cat > src/frontend/components/PromptCreation.jsx << 'EOF'
import TasksList from './TasksList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';

const PromptCreation = () => {
  return (
    <>
      <TasksList />
      <RequirementsEditor />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
    </>
  );
};

export default PromptCreation;
EOF

echo "\033[32mDone: $goal\033[0m\n"