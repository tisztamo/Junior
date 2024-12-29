#!/bin/sh
set -e
goal="Implement Details component and wrap TerminalComponent"
echo "Plan:"
echo "1. Implement the Details component with improved local storage update mechanism"
echo "2. Modify TerminalComponent to use the Details component"

# Create DetailsComponent.jsx
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

  return (
    <details open={isOpen()} onToggle={updateLocalStorage}>
      <summary>{props.generateHeader()}</summary>
      {props.children}
    </details>
  );
};

export default DetailsComponent;
EOF

# Modify TerminalComponent.jsx to wrap Terminal in DetailsComponent
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
    >
      <div class="rounded border p-2 w-full" ref={container}>
        {/* The terminal will be rendered inside this div */}
      </div>
    </DetailsComponent>
  );
};

export default TerminalComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"