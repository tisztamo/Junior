#!/bin/sh
set -e
goal="Notify server on terminal resize"
echo "Plan:"
echo "1. Create a new function sendTerminalResizeNotification to handle sending resize notifications."
echo "2. Modify TerminalComponent to use this new function and attach to xterm's resize event."

# Creating the sendTerminalResizeNotification.js file
cat > ./src/frontend/service/terminal/sendTerminalResizeNotification.js << 'EOF'
import terminalConnection from './terminalConnection';

export function sendTerminalResizeNotification(rows, cols) {
    terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'resize', rows, cols }));
}
EOF

# Modifying the TerminalComponent.jsx to use the new function and attach to the resize event
cat > ./src/frontend/components/terminal/TerminalComponent.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { setupXTerm } from '../../service/terminal/setupXTerm';
import { sendTerminalResizeNotification } from '../../service/terminal/sendTerminalResizeNotification';
import DetailsComponent from '../DetailsComponent';

const TerminalComponent = () => {
  let container;
  const { term, fitAddon } = setupXTerm();
  
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
      classes="rounded border p-2 w-full border-border bg-emphasize"
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