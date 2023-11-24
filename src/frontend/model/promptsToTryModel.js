import { createSignal } from 'solid-js';

const [promptsToTry, setPromptsToTry] = createSignal([
  { name: 'Sample 1', content: 'Content 1' },
  { name: 'Sample 2', content: 'Content 2' },
  { name: 'Sample 3', content: 'Content 3' },
]);

export { promptsToTry, setPromptsToTry };
