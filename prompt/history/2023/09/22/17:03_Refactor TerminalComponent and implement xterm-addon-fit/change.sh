#!/bin/sh
set -e
goal="Refactor TerminalComponent and implement xterm-addon-fit"
echo "Plan:"
echo "1. Create setupXTerm.js to abstract xterm initialization."
echo "2. Modify TerminalComponent.jsx to use setupXTerm and fit the terminal within onMount."
echo "3. Install xterm-addon-fit using npm."
echo "4. Implement xterm-addon-fit in TerminalComponent.jsx using the addon initialized in setupXTerm.js."

# Step 1: Create setupXTerm.js
cat > ./src/frontend/service/terminal/setupXTerm.js << 'EOF'
import { Terminal } from 'xterm';
import { FitAddon } from 'xterm-addon-fit';

export function initializeXTerm() {
  const term = new Terminal();
  const fitAddon = new FitAddon();
  term.loadAddon(fitAddon);
  
  return { term, fitAddon };
}
EOF

# Step 2: Modify TerminalComponent.jsx
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
    <div class="rounded border p-4 w-full" ref={container}>
      {/* The terminal will be rendered inside this div */}
    </div>
  );
};

export default TerminalComponent;
EOF

# Step 3: Install xterm-addon-fit using npm
npm install xterm-addon-fit

echo "\033[32mDone: $goal\033[0m\n"