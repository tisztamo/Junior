#!/bin/sh
set -e
goal="Rearrange components and add interactive help"
echo "Plan:"
echo "1. Modify PromptsToTry.jsx to rearrange components."
echo "2. Create PromptsToTryHelp.jsx for the new interactive component."
echo "3. Update PromptCreation.jsx to include the new component."

# Modify PromptsToTry.jsx
cat > src/frontend/components/promptCreation/PromptsToTry.jsx << EOF
import { For, onMount } from 'solid-js';
import { promptsToTry, setPromptsToTry } from '../../model/promptsToTryModel';
import { fetchPromptsToTry } from '../../service/fetchPromptsToTry';
import PromptsToTryHelp from './PromptsToTryHelp';

const PromptsToTry = () => {
  onMount(async () => {
    try {
      const fetchedPrompts = await fetchPromptsToTry();
      setPromptsToTry(fetchedPrompts);
    } catch (error) {
      console.error('Error fetching prompts to try:', error);
    }
  });

  return (
    <div class="w-full flex flex-nowrap p-2 overflow-x-auto">
      <div class="shrink-0">Prompts to try: <PromptsToTryHelp /></div>
      <For each={promptsToTry()}>{(prompt) => 
        <a href="#" class="ml-2 cursor-pointer text-blue-500 bg-transparent rounded px-4 whitespace-nowrap">{prompt.name}</a>
      }</For>
    </div>
  );
};

export default PromptsToTry;
EOF

# Create PromptsToTryHelp.jsx
cat > src/frontend/components/promptCreation/PromptsToTryHelp.jsx << EOF
const PromptsToTryHelp = () => {
  const showAlert = () => {
    alert('These are sample prompts you can use with Junior. Create a prompt/totry folder in your project directory and add files to have them displayed here.');
  };

  return (
    <span class="inline-block cursor-pointer text-blue-500" onClick={showAlert}>❓</span>
  );
};

export default PromptsToTryHelp;
EOF

# Update PromptCreation.jsx
cat > src/frontend/components/PromptCreation.jsx << EOF
import TasksList from './TasksList';
import AttentionFileList from './AttentionFileList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';
import PromptsToTry from "./promptCreation/PromptsToTry";

const PromptCreation = () => {
  return (
    <>
      <PromptsToTry />
      <TasksList />
      <RequirementsEditor />
      <AttentionFileList />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
    </>
  );
};

export default PromptCreation;
EOF

echo "\033[32mDone: $goal\033[0m\n"