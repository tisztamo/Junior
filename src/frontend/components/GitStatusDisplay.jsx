import { onMount, createEffect } from 'solid-js';
import { gitStatus } from '../stores/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let statusContainer;

  onMount(fetchGitStatus);

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue) {
      if (gitStatusValue.error) {
        statusContainer.innerText = `${gitStatusValue.message}\n${gitStatusValue.error.stderr}`;
      } else if (gitStatusValue.message && gitStatusValue.message !== '') {
        statusContainer.innerText = gitStatusValue.message;
      }
    }
  });

  return (
    <pre
      ref={statusContainer}
      class={`rounded overflow-auto max-w-full ${gitStatus() && gitStatus().message && gitStatus().message !== '' ? 'block' : 'hidden'}`}
    />
  );
};

export default GitStatusDisplay;
