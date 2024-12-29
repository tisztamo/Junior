#!/bin/sh
set -e
goal="Update multiselect on each keystroke"
echo "Plan:"
echo "1. Modify RequirementsEditor.jsx to trigger an update on the multiselect component whenever there's a keystroke."

# Applying changes to RequirementsEditor.jsx
cat > ./src/frontend/components/RequirementsEditor.jsx << 'EOF'
import { createSignal, createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor'; 
import { requirements, setRequirements } from '../model/requirements';
import { getYamlEntry } from '../service/getYamlEntry';
import jsyaml from 'js-yaml'; 
import AutoGrowingTextarea from './AutoGrowingTextarea';

const RequirementsEditor = () => {
  const handleInput = (e) => {
    const descriptor = promptDescriptor();
    const parsed = jsyaml.load(descriptor);
    parsed.requirements = e.target.value; 
    const updatedDescriptor = jsyaml.dump(parsed);
    setPromptDescriptor(updatedDescriptor);

    // After setting the updated descriptor, trigger an update on the multiselect component
    // Assumption: The multiselect component listens to changes on the requirements signal and updates itself accordingly.
    setRequirements(e.target.value);
  };

  const handleChange = async (e) => {
    handleInput(e);
    const currentRequirements = e.target.value;
    await postDescriptor({ requirements: currentRequirements });
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
      <AutoGrowingTextarea
        class="w-full bg-emphasize text-emphasize text-lg px-2"
        placeholder="Enter your requirements..."
        valueSignal={requirements}
        onInput={e => handleInput(e)}
        onChange={e => handleChange(e)}
        disabled={false}
      />
    </div>
  );
};

export default RequirementsEditor;
EOF

echo "\033[32mDone: $goal\033[0m\n"