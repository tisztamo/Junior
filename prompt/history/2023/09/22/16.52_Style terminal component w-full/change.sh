#!/bin/sh
set -e
goal="Style terminal component w-full"
echo "Plan:"
echo "1. Add w-full Tailwind class to the terminal container in TerminalComponent.jsx."

# Update the TerminalComponent.jsx
cat > ./src/frontend/components/terminal/TerminalComponent.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';

const TerminalComponent = () => {
  let container;
  const term = new Terminal();
  
  onMount(() => {
    term.open(container);

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
    <div class="rounded border p-4 w-full" ref={container}>
      {/* The terminal will be rendered inside this div */}
    </div>
  );
};

export default TerminalComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"