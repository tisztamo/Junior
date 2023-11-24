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
