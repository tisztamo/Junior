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

  const handleClick = async (prompt) => {
    setRequirements(prompt.content);
    await postDescriptor({ requirements: prompt.content });
  };

  return (
    <div class="flex space-x-4 overflow-x-auto">
      <div>Prompts to try:</div>
      <For each={promptsToTry()}>{(prompt) => 
        <a href="#" class="cursor-pointer ml-2 text-blue-500 bg-transparent rounded px-4" onClick={() => handleClick(prompt)}>{prompt.name}</a>
      }</For>
    </div>
  );
};

export default PromptsToTry;
