#!/bin/sh
set -e
goal="Refactor RequirementsEditor event handlers"
echo "Plan:"
echo "1. Refactor handleRequirementsChange to bind to change events and simplify it"
echo "2. Create a new handler for input events"
echo "3. Update RequirementsEditor.jsx to incorporate these changes"

# Refactor RequirementsEditor.jsx
cat << 'EOF' > src/frontend/components/RequirementsEditor.jsx
import { createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor'; // Added setPromptDescriptor
import { requirements, setRequirements } from '../model/requirements';
import { getYamlEntry } from '../service/getYamlEntry';
import jsyaml from 'js-yaml'; // Importing the YAML parser

const RequirementsEditor = () => {
  const handleRequirementsChange = async (e) => {
    await postDescriptor({ requirements: e.target.value });
  };

  const handleInput = (e) => {
    const descriptor = promptDescriptor();
    const parsed = jsyaml.safeLoad(descriptor); // Parse as YAML
    parsed.requirements = e.target.value; // Update the requirements section
    const updatedDescriptor = jsyaml.safeDump(parsed); // Convert back to string
    setPromptDescriptor(updatedDescriptor);
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
        onInput={e => handleInput(e)}
        onChange={e => handleRequirementsChange(e)}
      />
    </div>
  );
};

export default RequirementsEditor;
EOF

echo "\033[32mDone: $goal\033[0m\n"