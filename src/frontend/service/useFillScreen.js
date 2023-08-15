import { onCleanup } from 'solid-js';

export default function useFillScreen(containerRef) {
  const resizeContent = () => {
    if (containerRef()) {
      const vh = Math.max(document.documentElement.clientHeight || 0, window.innerHeight || 0);
      containerRef().style.height = `${vh}px`;
    }
  };

  window.addEventListener('resize', resizeContent);
  resizeContent();  // call once to set the initial height

  onCleanup(() => {
    window.removeEventListener('resize', resizeContent);
  });
}
