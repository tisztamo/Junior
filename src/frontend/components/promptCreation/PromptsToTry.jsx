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
