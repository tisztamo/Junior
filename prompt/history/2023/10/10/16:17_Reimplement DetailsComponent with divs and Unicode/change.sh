#!/bin/sh
set -e
goal="Reimplement DetailsComponent with divs and Unicode"
echo "Plan:"
echo "1. Replace details tag with divs, manage open/close with SolidJS."
echo "2. Use Unicode chars (triangles) to indicate open/close state."
echo "3. Ensure styling and interactivity with TailwindCSS and SolidJS."
echo "4. Adhere to project guidelines regarding code style/structuring."
echo "5. Render details content always, toggle display with isOpen state."
echo "6. Adjust padding around Unicode characters."

# Replacing existing DetailsComponent.jsx file with the updated implementation.
cat > ./src/frontend/components/DetailsComponent.jsx << 'EOF'
import { createSignal, onCleanup, onMount } from 'solid-js';

const DetailsComponent = (props) => {
  const [isOpen, setIsOpen] = createSignal(props.defaultState === 'open');

  // Unicode characters for open and close states.
  const closeChar = '\u25B6';  // Right-pointing triangle
  const openChar = '\u25BC';  // Down-pointing triangle
  
  onMount(() => {
    const savedState = localStorage.getItem("Junior.terminal.isOpen");
    if (savedState) {
      setIsOpen(savedState === 'true');
    }
  });
  
  const updateLocalStorage = (currentState) => {
    setIsOpen(currentState);
    localStorage.setItem("Junior.terminal.isOpen", currentState ? 'true' : 'false');
  };

  const classes = props.classes || "";
  const toggleDetails = () => updateLocalStorage(!isOpen());

  return (
    <div class={classes}>
      <div class="px-2 cursor-pointer" onClick={toggleDetails}>
        <span class="pl-1 pr-2">{isOpen() ? openChar : closeChar}</span>{props.generateHeader()}
      </div>
      <div class={`transition-height duration-300 ${isOpen() ? 'block' : 'hidden'} pt-2`}>
        {props.children}
      </div>
    </div>
  );
};

export default DetailsComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"