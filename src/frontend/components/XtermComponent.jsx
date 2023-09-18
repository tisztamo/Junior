import { onCleanup, onMount } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';

const XtermComponent = () => {
  let container;
  const term = new Terminal();
  
  onMount(() => {
    term.open(container);
  });
  
  // Ensure terminal instance gets destroyed on component cleanup
  onCleanup(() => {
    term.dispose();
  });

  return (
    <div class="rounded border p-4" ref={container}>
      {/* The terminal will be rendered inside this div */}
    </div>
  );
};

export default XtermComponent;
