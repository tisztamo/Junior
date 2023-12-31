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
        <span class="pl-1 pr-2">{isOpen() ? openChar : closeChar}</span>
        {isOpen() ? null : props.generateHeader()} {/* Conditionally display generateHeader */}
      </div>
      <div class={`transition-height duration-300 ${isOpen() ? 'block' : 'hidden'} pt-2`}>
        {props.children}
      </div>
    </div>
  );
};

export default DetailsComponent;
