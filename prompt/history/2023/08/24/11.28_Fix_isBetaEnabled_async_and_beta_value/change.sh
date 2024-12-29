#!/bin/sh
set -e
goal="Fix isBetaEnabled async and beta value"
echo "Plan:"
echo "1. Modify the RequirementsEditor.jsx file to await the isBetaEnabled function and update the textarea value when not in beta."

cat > src/frontend/components/RequirementsEditor.jsx << 'EOF'
import { createEffect, onCleanup } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor'; 
import { requirements, setRequirements } from '../model/requirements';
import { getYamlEntry } from '../service/getYamlEntry';
import isBetaEnabled from '../service/config/isBetaEnabled'; 
import jsyaml from 'js-yaml'; 
import AutoGrowingTextarea from './AutoGrowingTextarea';

const RequirementsEditor = () => {
  let isBeta = false;

  const init = async () => {
    isBeta = await isBetaEnabled();
  };

  createEffect(() => {
    init();
  });

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
      <AutoGrowingTextarea
        class="w-full bg-emphasize text-emphasize text-lg"
        placeholder={isBeta ? "Enter your requirements..." : "This is disabled for now. Call with 'npx junior-web -- --beta' to enable."}
        value={isBeta ? requirements() : ''}
        onInput={e => handleInput(e)}
        onChange={e => handleRequirementsChange(e)}
        disabled={!isBeta}
      />
    </div>
  );
};

export default RequirementsEditor;
EOF

echo "\033[32mDone: $goal\033[0m\n"