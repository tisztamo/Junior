#!/bin/sh
set -e
goal="Fix overwriting onInput in AutoGrowingTextarea"
echo "Plan:"
echo "1. Modify AutoGrowingTextarea.jsx to invoke both its internal onInput handler and any onInput handler provided via props."

# Applying changes to AutoGrowingTextarea.jsx
cat > ./src/frontend/components/AutoGrowingTextarea.jsx << 'EOF'
import { createEffect } from 'solid-js';

const AutoGrowingTextarea = (props) => {
  let textRef;
  
  const resize = () => {
    textRef.style.height = 'auto';
    textRef.style.height = textRef.scrollHeight + 'px';
  }

  // Handle the input event by calling resize and any onInput function provided in props
  const handleInput = (event) => {
    if (props.onInput) {
      props.onInput(event);
    }
    resize();
  }

  createEffect(() => {
    if (props.valueSignal) {
      props.valueSignal();
    }
    resize();
  });

  return (
    <textarea
      {...props}
      ref={textRef}
      onInput={handleInput}
      rows="1"
      style="overflow:hidden"
      value={props.valueSignal ? props.valueSignal() : props.value}
    />
  );
};

export default AutoGrowingTextarea;
EOF

echo "\033[32mDone: $goal\033[0m\n"