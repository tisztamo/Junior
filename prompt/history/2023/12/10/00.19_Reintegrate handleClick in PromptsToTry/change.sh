#!/bin/sh
set -e
goal="Reintegrate handleClick in PromptsToTry"
echo "Plan:"
echo "1. Add handleClick function."
echo "2. Update <a> element to use onClick with handleClick."

# Update PromptsToTry.jsx
cat > src/frontend/components/promptCreation/PromptsToTry.jsx << EOF
import { For, onMount } from 'solid-js';
import { promptsToTry, setPromptsToTry } from '../../model/promptsToTryModel';
import { fetchPromptsToTry } from '../../service/fetchPromptsToTry';
import PromptsToTryHelp from './PromptsToTryHelp';
import { setRequirements } from '../../model/requirements';
import postDescriptor from '../../service/postDescriptor';

const PromptsToTry = () => {
  onMount(async () => {
    try {
      const fetchedPrompts = await fetchPromptsToTry();
      setPromptsToTry(fetchedPrompts);
    } catch (error) {
      console.error('Error fetching prompts to try:', error);
    }
  });

  const handleClick = async (prompt) => {
    setRequirements(prompt.content);
    await postDescriptor({ requirements: prompt.content });
  };

  return (
    <div class="w-full flex flex-nowrap p-2 overflow-x-auto">
      <div class="shrink-0">Prompts to try: <PromptsToTryHelp /></div>
      <For each={promptsToTry()}>{(prompt) => 
        <a href="#" class="ml-2 cursor-pointer text-blue-500 bg-transparent rounded px-4 whitespace-nowrap" onClick={() => handleClick(prompt)}>{prompt.name}</a>
      }</For>
    </div>
  );
};

export default PromptsToTry;
EOF
echo "\033[32mDone: $goal\033[0m\n"