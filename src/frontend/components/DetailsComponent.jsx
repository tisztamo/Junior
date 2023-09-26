import { createSignal, onCleanup, onMount } from 'solid-js';

const DetailsComponent = (props) => {
  const [isOpen, setIsOpen] = createSignal(props.defaultState === 'open');

  // Extract localStorage key from props
  const localStorageKey = props.localStorageKey || "";

  // On mount, check local storage and set state accordingly
  onMount(() => {
    const savedState = localStorage.getItem(localStorageKey);
    if (savedState) {
      setIsOpen(savedState === 'true');
    }
  });

  // Update local storage whenever isOpen changes
  const updateLocalStorage = () => {
    // Capture the open state from the details tag before saving
    const currentState = event.currentTarget.open;
    setIsOpen(currentState);
    localStorage.setItem(localStorageKey, currentState ? 'true' : 'false');
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
