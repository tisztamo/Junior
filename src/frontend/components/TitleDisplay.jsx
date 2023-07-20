import { createSignal } from 'solid-js';

const TitleDisplay = () => {
  const [title] = createSignal('Junior');

  return (
    <h1 class="text-center text-3xl mt-6">{title}</h1>
  );
};

export default TitleDisplay;
