import { onMount, createEffect } from 'solid-js';
import { gitStatus, setGitStatus } from '../stores/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(async () => {
    const status = await fetchGitStatus();
    setGitStatus(status);
  });

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue && gitStatusValue.status && gitStatusValue.status !== '') {
      statusContainer.innerText = gitStatusValue.status;
    }
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() && gitStatus().status && gitStatus().status !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;
