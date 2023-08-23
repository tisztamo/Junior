import { onCleanup, onMount } from 'solid-js';

const AutoGrowingTextarea = (props) => {
  let textRef;

  const resize = () => {
    textRef.style.height = 'auto';
    textRef.style.height = textRef.scrollHeight + 'px';
  }

  // Use the onMount lifecycle hook to ensure the ref is available
  onMount(() => {
    textRef.addEventListener('input', resize, false);
    resize();  // To resize on initialization
  });

  // When the component unmounts, cleanup the event listener
  onCleanup(() => {
    textRef.removeEventListener('input', resize, false);
  });

  return (
    <textarea
      {...props}
      ref={textRef}
      rows="1" // Start with one row
      style="overflow:hidden" // Hide the scrollbar
    />
  );
};

export default AutoGrowingTextarea;
