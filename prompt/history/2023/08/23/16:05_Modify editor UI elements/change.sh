#!/bin/sh
set -e
goal="Modify editor UI elements"
echo "Plan:"
echo "1. Modify RequirementsEditor to have 5 rows for textarea."
echo "2. Reduce space between the TasksList and RequirementsEditor components."

# 1. Modify RequirementsEditor to have 5 rows for textarea.
cat > src/frontend/components/RequirementsEditor.jsx << 'EOF'
import { createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor'; 
import { requirements, setRequirements } from '../model/requirements';
import { getYamlEntry } from '../service/getYamlEntry';
import jsyaml from 'js-yaml'; 

const RequirementsEditor = () => {
  const handleRequirementsChange = async (e) => {
    await postDescriptor({ requirements: e.target.value });
  };

  const handleInput = (e) => {
    const descriptor = promptDescriptor();
    const parsed = jsyaml.load(descriptor);
    parsed.requirements = e.target.value; 
    const updatedDescriptor = jsyaml.dump(parsed);
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
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-1 rounded border border-border mt-2">
      <textarea
        class="w-full bg-emphasize text-emphasize text-lg"
        placeholder="Enter your requirements..."
        value={requirements()}
        rows="5"
        onInput={e => handleInput(e)}
        onChange={e => handleRequirementsChange(e)}
      />
    </div>
  );
};

export default RequirementsEditor;
EOF

# 2. Reduce space between the TasksList and RequirementsEditor components.
# The space is defined by mt-4 in the RequirementsEditor and by border-border.
# We reduce the mt-4 to mt-2, which makes the space between them smaller.

echo "\033[32mDone: $goal\033[0m\n"