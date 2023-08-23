#!/bin/sh
set -e
goal="Refactor requirements editor component"
echo "Plan:"
echo "1. Modify RequirementsEditor.jsx to utilize promptDescriptor and remove signal"
echo "2. Adjust placeholder and remove label"

cat > src/frontend/components/RequirementsEditor.jsx << 'EOF'
import { createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor } from '../model/promptDescriptor';

const RequirementsEditor = () => {
  let requirements = promptDescriptor().requirements || '';

  const handleRequirementsChange = async (e) => {
    requirements = e.target.value;
    await postDescriptor({ requirements: requirements });
  };

  createEffect(() => {
    requirements = promptDescriptor().requirements || '';
  });

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-2 rounded border border-border mt-4">
      <textarea
        class="w-full bg-emphasize text-emphasize text-lg"
        placeholder="Enter your requirements..."
        value={requirements}
        onInput={e => handleRequirementsChange(e)}
      />
    </div>
  );
};

export default RequirementsEditor;
EOF

echo "\033[32mDone: $goal\033[0m\n"