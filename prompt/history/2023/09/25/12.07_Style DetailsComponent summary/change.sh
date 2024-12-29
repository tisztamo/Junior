#!/bin/sh
set -e
goal="Style DetailsComponent summary"
echo "Plan:"
echo "1. Adjust the styling of the summary within the DetailsComponent.jsx."
cat > ./src/frontend/components/DetailsComponent.jsx << 'EOF'
import { createSignal, onCleanup, onMount } from 'solid-js';

const DetailsComponent = (props) => {
  const [isOpen, setIsOpen] = createSignal(props.defaultState === 'open');

  // On mount, check local storage and set state accordingly
  onMount(() => {
    const savedState = localStorage.getItem("Junior.terminal.isOpen");
    if (savedState) {
      setIsOpen(savedState === 'true');
    }
  });

  // Update local storage whenever isOpen changes
  const updateLocalStorage = () => {
    // Capture the open state from the details tag before saving
    const currentState = event.currentTarget.open;
    setIsOpen(currentState);
    localStorage.setItem("Junior.terminal.isOpen", currentState ? 'true' : 'false');
  };

  const classes = props.classes || "";

  return (
    <details class={classes} open={isOpen()} onToggle={updateLocalStorage}>
      <summary class="px-2">
        <span class="pl-2">{props.generateHeader()}</span>
      </summary>
      <div class="pt-2">
        {props.children}
      </div>
    </details>
  );
};

export default DetailsComponent;
EOF
echo "\033[32mDone: $goal\033[0m\n"