#!/bin/sh
set -e
goal="Update SolidJS components"
echo "Plan:"
echo "1. Modify PromptsToTry.jsx to adjust link styling."
echo "2. Update RequirementsEditor.jsx to use untrack."

# Update PromptsToTry.jsx
cat > src/frontend/components/promptCreation/PromptsToTry.jsx << 'EOF'
import { For } from 'solid-js';
import { promptsToTry } from '../../model/promptsToTryModel';
import { setRequirements } from '../../model/requirements';

const PromptsToTry = () => {
  const handleClick = (promptContent) => {
    setRequirements(promptContent);
  };

  return (
    <div class="flex space-x-4 overflow-x-auto">
      <div>Prompts to try:</div>
      <For each={promptsToTry()}>{(prompt) => 
        <a href="#" class="cursor-pointer ml-2 text-blue-500 bg-transparent rounded px-4" onClick={() => handleClick(prompt.name)}>{prompt.name}</a>
      }</For>
    </div>
  );
};

export default PromptsToTry;
EOF

# Update RequirementsEditor.jsx
cat > src/frontend/components/RequirementsEditor.jsx << 'EOF'
import { createSignal, createEffect, untrack } from 'solid-js';
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
    if (currentRequirements !== untrack(requirements)) {
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