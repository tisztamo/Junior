#!/bin/sh
set -e
goal="Fix onInput binding for AutoGrowingTextarea"
echo "Plan:"
echo "1. Update the AutoGrowingTextarea.jsx to bind the onInput event to the resize function."

cat > src/frontend/components/AutoGrowingTextarea.jsx << 'EOF'
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
      onInput={resize} // Bind onInput event to the resize function
      rows="1" // Start with one row
      style="overflow:hidden" // Hide the scrollbar
    />
  );
};

export default AutoGrowingTextarea;
EOF

echo "\033[32mDone: $goal\033[0m\n"