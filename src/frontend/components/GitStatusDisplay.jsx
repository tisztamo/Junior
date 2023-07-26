import { onMount, createEffect, onCleanup } from 'solid-js';
import { gitStatus, setGitStatus } from '../stores/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(async () => {
    const status = await fetchGitStatus();
    setGitStatus(status);
  });

  createEffect(() => {
    if (gitStatus() !== '') {
      statusContainer.innerText = gitStatus();
    }
  });

  onCleanup(() => {
    setGitStatus('');
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;
