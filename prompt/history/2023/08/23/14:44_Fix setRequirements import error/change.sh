#!/bin/sh
set -e
goal="Fix setRequirements import error"
echo "Plan:"
echo "1. Import setRequirements in RequirementsEditor.jsx"

cat > src/frontend/components/RequirementsEditor.jsx << 'EOF'
import { createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor } from '../model/promptDescriptor';
import { requirements, setRequirements } from '../model/requirements'; // Imported setRequirements
import { getYamlEntry } from '../service/getYamlEntry';

let lastPostedTime = 0;
let lastThrottledValue = null;

const RequirementsEditor = () => {
  const handleRequirementsChange = async (e) => {
    const now = Date.now();
    if (now - lastPostedTime < 1000) {
      lastThrottledValue = e.target.value; // Store the last throttled value
      setTimeout(() => {
        // Check after 1 second if lastThrottledValue is not null and send the request
        if (lastThrottledValue !== null) {
          postDescriptor({ requirements: lastThrottledValue });
          lastThrottledValue = null; // Reset the lastThrottledValue
        }
      }, 1000 - (now - lastPostedTime));
      return;
    }
    lastPostedTime = now;
    await postDescriptor({ requirements: e.target.value });
  };

  createEffect(() => {
    const descriptor = promptDescriptor();
    const currentRequirements = getYamlEntry(descriptor, 'requirements') || '';
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