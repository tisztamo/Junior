import { createSignal } from 'solid-js';

const [gitStatus, setGitStatus] = createSignal('');

export { gitStatus, setGitStatus };
