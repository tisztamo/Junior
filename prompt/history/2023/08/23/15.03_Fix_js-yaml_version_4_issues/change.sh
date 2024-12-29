#!/bin/sh
set -e
goal="Fix js-yaml version 4 issues"
echo "Plan:"
echo "1. Update `jsyaml.load` to `jsyaml.dump` in RequirementsEditor.jsx"
echo "2. Update `jsyaml.safeDump` to `jsyaml.dump` in RequirementsEditor.jsx"

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
    const updatedDescriptor = jsyaml.dump(parsed);  // Changed from jsyaml.safeDump
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