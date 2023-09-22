#!/bin/sh
set -e
goal="Change terminal wrapper div padding to p-2"
echo "Plan:"
echo "1. Modify the TerminalComponent.jsx to change the padding of the terminal wrapper div."

# Editing TerminalComponent.jsx file
cat > ./src/frontend/components/terminal/TerminalComponent.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { initializeXTerm } from '../../service/terminal/setupXTerm';

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
    <div class="rounded border p-2 w-full" ref={container}>
      {/* The terminal will be rendered inside this div */}
    </div>
  );
};

export default TerminalComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"