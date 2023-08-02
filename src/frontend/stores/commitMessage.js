import { createSignal } from 'solid-js';

const [commitMessage, setCommitMessage] = createSignal('');

export { commitMessage, setCommitMessage };
