#!/bin/sh
set -e
goal="Implement clickable prompts feature"
echo "Plan:"
echo "1. Modify PromptsToTry.jsx to use a tags and update classes."
echo "2. Implement click handler to set requirements."

# Modifying PromptsToTry.jsx
cat > src/frontend/components/promptCreation/PromptsToTry.jsx << 'EOF'
import { For } from 'solid-js';
import { promptsToTry } from '../../model/promptsToTryModel';
import { setRequirements } from '../../model/requirements';

const PromptsToTry = () => {
  const handleClick = (promptContent) => {
    setRequirements(promptContent);
  };

  return (
    <div class="flex space-x-4 overflow-x-auto py-2">
      <div>Prompts to try:</div>
      <For each={promptsToTry()}>{(prompt) => 
        <a href="#" class="cursor-pointer ml-2 text-blue-500 bg-gray-200 rounded px-4 py-2" onClick={() => handleClick(prompt.name)}>{prompt.name}</a>
      }</For>
    </div>
  );
};

export default PromptsToTry;
EOF

echo "\033[32mDone: $goal\033[0m\n"