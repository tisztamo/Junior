#!/bin/sh
set -e
goal="Add event handler for postDescriptor call"
echo "Plan:"
echo "1. Modify the RequirementsEditor.jsx to include the new event handler."
echo "2. The event handler will call postDescriptor with the requirements on change."

cat << 'EOF' > src/frontend/components/RequirementsEditor.jsx
import { createSignal, createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor'; 
import { requirements, setRequirements } from '../model/requirements';
import { getYamlEntry } from '../service/getYamlEntry';
import isBetaEnabled from '../service/config/isBetaEnabled'; 
import jsyaml from 'js-yaml'; 
import AutoGrowingTextarea from './AutoGrowingTextarea';

const RequirementsEditor = () => {
  const [isBeta, setIsBeta] = createSignal(false);

  const init = async () => {
    const betaStatus = await isBetaEnabled();
    setIsBeta(betaStatus);
  };

  createEffect(init);

  const handleInput = (e) => {
    const descriptor = promptDescriptor();
    const parsed = jsyaml.load(descriptor);
    parsed.requirements = e.target.value; 
    const updatedDescriptor = jsyaml.dump(parsed);
    setPromptDescriptor(updatedDescriptor);
  };

  const handleChange = async (e) => {
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
        class="w-full bg-emphasize text-emphasize text-lg"
        placeholder={isBeta() ? "Enter your requirements..." : "This is disabled for now. Call with 'npx junior-web -- --beta' to enable."}
        value={isBeta() ? requirements() : ''}
        onInput={e => handleInput(e)}
        onChange={e => handleChange(e)}
        disabled={!isBeta()}
      />
    </div>
  );
};

export default RequirementsEditor;
EOF

echo "\033[32mDone: $goal\033[0m\n"