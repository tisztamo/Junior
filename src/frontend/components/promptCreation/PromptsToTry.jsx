import { For } from 'solid-js';
import { promptsToTry } from '../../model/promptsToTryModel';

const PromptsToTry = () => {
  return (
    <div class="flex space-x-4 overflow-x-auto py-2">
      <div class="font-bold">Prompts to try:</div>
      <For each={promptsToTry()}>{(prompt) => 
        <div class="bg-gray-200 rounded px-4 py-2">{prompt.name}</div>
      }</For>
    </div>
  );
};

export default PromptsToTry;
