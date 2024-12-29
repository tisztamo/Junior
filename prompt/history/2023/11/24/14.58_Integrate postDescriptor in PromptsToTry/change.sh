#!/bin/sh
set -e
goal="Integrate postDescriptor in PromptsToTry"
echo "Plan:"
echo "1. Modify PromptsToTry.jsx to call postDescriptor after setRequirements."
echo "2. Import postDescriptor in PromptsToTry.jsx."

# Modifying src/frontend/components/promptCreation/PromptsToTry.jsx
cat > src/frontend/components/promptCreation/PromptsToTry.jsx << 'EOF'
import { For } from 'solid-js';
import { promptsToTry } from '../../model/promptsToTryModel';
import { setRequirements } from '../../model/requirements';
import postDescriptor from '../../service/postDescriptor'; // Importing postDescriptor

const PromptsToTry = () => {
  const handleClick = async (promptContent) => {
    setRequirements(promptContent);
    await postDescriptor({ requirements: promptContent }); // Calling postDescriptor after setRequirements
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

echo "\033[32mDone: $goal\033[0m\n"