#!/bin/sh
set -e
goal="Fix localStorage key issue in DetailsComponent"
echo "Plan:"
echo "1. Modify DetailsComponent to use passed localStorage key."
echo "2. Update TerminalComponent to pass the correct localStorage key."

cat > ./src/frontend/components/DetailsComponent.jsx << 'EOF'
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
EOF

cat > ./src/frontend/components/terminal/TerminalComponent.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { setupXTerm } from '../../service/terminal/setupXTerm';
import { sendTerminalResizeNotification } from '../../service/terminal/sendTerminalResizeNotification';
import DetailsComponent from '../DetailsComponent';
import VirtualKey from './VirtualKey';
import terminalVirtualKeyBindings from '../../config/terminalVirtualKeyBindings';

const TerminalComponent = () => {
  let container;
  const { term, fitAddon } = setupXTerm();

  const sendVirtualKey = (key) => {
    terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'input', data: key }));
    term.focus();
  };

  onMount(() => {
    term.open(container);
    fitAddon.fit();

    const { rows, cols } = term;
    sendTerminalResizeNotification(rows, cols);

    terminalConnection.setOnDataReceived((data) => {
      term.write(data);
    });

    term.onData((data) => {
      terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'input', data }));
    });

    term.onResize(({ newRows, newCols }) => {
      sendTerminalResizeNotification(newRows, newCols);
    });
  });
  
  onCleanup(() => {
    term.dispose();
    terminalConnection.closeConnection();
  });

  return (
    <DetailsComponent 
      defaultState="closed"
      localStorageKey="Junior.terminal.isOpen"
      generateHeader={() => "Terminal"}
      classes="rounded border p-2 w-full border-border bg-emphasize"
    >
      <div ref={container}></div>
      <div class="flex overflow-x-auto whitespace-nowrap">
        {terminalVirtualKeyBindings().map(({ label, action }) => (
          <VirtualKey label={label} action={() => sendVirtualKey(action)} />
        ))}
      </div>
    </DetailsComponent>
  );
};

export default TerminalComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"