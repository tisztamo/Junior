#!/bin/sh
set -e
goal="Update DetailsComponent and TerminalComponent"
echo "Plan:"
echo "1. Modify DetailsComponent.jsx to accept a 'classes' prop for styling the details tag."
echo "2. Update TerminalComponent.jsx to pass classes to the DetailsComponent and remove them from the inner div."

# 1. Modify DetailsComponent.jsx
cat > ./src/frontend/components/DetailsComponent.jsx << 'EOF'
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

  const classes = props.classes || "";

  return (
    <details class={classes} open={isOpen()} onToggle={updateLocalStorage}>
      <summary>{props.generateHeader()}</summary>
      {props.children}
    </details>
  );
};

export default DetailsComponent;
EOF

# 2. Update TerminalComponent.jsx
cat > ./src/frontend/components/terminal/TerminalComponent.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { initializeXTerm } from '../../service/terminal/setupXTerm';
import DetailsComponent from '../DetailsComponent';

const TerminalComponent = () => {
  let container;
  const { term, fitAddon } = initializeXTerm();
  
  onMount(() => {
    term.open(container);
    fitAddon.fit();

    terminalConnection.setOnDataReceived((data) => {
      term.write(data);
    });

    term.onData((data) => {
      terminalConnection.sendDataToTerminal(data);
    });
  });
  
  // Ensure terminal instance gets destroyed and WebSocket connection gets closed on component cleanup
  onCleanup(() => {
    term.dispose();
    terminalConnection.closeConnection();
  });

  return (
    <DetailsComponent 
      defaultState="closed"
      localStorageKey="terminalState"
      generateHeader={() => "Terminal"}
      classes="rounded border p-2 w-full"
    >
      <div ref={container}>
        {/* The terminal will be rendered inside this div */}
      </div>
    </DetailsComponent>
  );
};

export default TerminalComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"