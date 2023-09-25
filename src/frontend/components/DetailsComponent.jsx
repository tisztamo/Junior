import { createSignal, onCleanup, onMount } from 'solid-js';

const DetailsComponent = (props) => {
  const [isOpen, setIsOpen] = createSignal(props.defaultState || 'open');

  // On mount, check local storage and set state accordingly
  onMount(() => {
    const savedState = localStorage.getItem(props.localStorageKey);
    if (savedState) {
      setIsOpen(savedState === 'open');
    }
  });

  // Update local storage whenever isOpen changes
  const updateLocalStorage = () => {
    localStorage.setItem(props.localStorageKey, isOpen() ? 'open' : 'closed');
  };

  return (
    <details open={isOpen()} onToggle={updateLocalStorage}>
      <summary>{props.generateHeader()}</summary>
      {props.children}
    </details>
  );
};

export default DetailsComponent;
