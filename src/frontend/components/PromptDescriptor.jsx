import { onMount, onCleanup } from 'solid-js';
import { fetchDescriptor } from '../service/fetchDescriptor';
import { fetchGitStatus } from '../service/fetchGitStatus';
import { useWebsocket } from '../service/useWebsocket';
import { promptDescriptor, setPromptDescriptor } from '../stores/promptDescriptor';

const PromptDescriptor = () => {

  onMount(async () => {
    const text = await fetchDescriptor();
    setPromptDescriptor(text);
  });

  useWebsocket(async (e) => {
    if (e.data === 'update') {
      const text = await fetchDescriptor();
      setPromptDescriptor(text);
      // Fetch git status when an update event is received
      fetchGitStatus();
    }
  });

  onCleanup(() => {
    setPromptDescriptor('');
  });

  return (
    <div class="overflow-auto max-w-full">
      <div class="whitespace-pre-wrap overflow-x-scroll overflow-y-auto font-mono">
        {promptDescriptor()}
      </div>
    </div>
  );
};

export default PromptDescriptor;
