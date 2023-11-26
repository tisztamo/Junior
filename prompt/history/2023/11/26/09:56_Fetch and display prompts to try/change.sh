#!/bin/sh
set -e
goal="Fetch and display prompts to try"
echo "Plan:"
echo "1. Create fetchPromptsToTry.js to fetch data from /promptstotry endpoint."
echo "2. Modify PromptsToTry.jsx to use the new fetcher on component creation."

# Creating fetchPromptsToTry.js
cat > src/frontend/service/fetchPromptsToTry.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';

export const fetchPromptsToTry = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/promptstotry`);
  if (!response.ok) {
    throw new Error('Failed to fetch prompts to try');
  }
  return await response.json();
};
EOF
echo "Created fetchPromptsToTry.js"

# Modifying PromptsToTry.jsx
cat > src/frontend/components/promptCreation/PromptsToTry.jsx << 'EOF'
import { For, onMount } from 'solid-js';
import { promptsToTry, setPromptsToTry } from '../../model/promptsToTryModel';
import { fetchPromptsToTry } from '../../service/fetchPromptsToTry';
import { setRequirements } from '../../model/requirements';
import postDescriptor from '../../service/postDescriptor'; // Importing postDescriptor

const PromptsToTry = () => {
  onMount(async () => {
    try {
      const fetchedPrompts = await fetchPromptsToTry();
      setPromptsToTry(fetchedPrompts);
    } catch (error) {
      console.error('Error fetching prompts to try:', error);
    }
  });

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
echo "Modified PromptsToTry.jsx"

echo "\033[32mDone: $goal\033[0m\n"