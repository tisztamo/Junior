#!/bin/sh
set -e
goal="Notify shell of terminal size changes and wrap all data in JSON"
echo "Plan:"
echo "1. Update the frontend TerminalComponent.jsx to fetch terminal size and send it to the backend."
echo "2. Update the backend setupTerminalServer.js to resize the terminal when size data is received."
echo "3. Ensure all outgoing data from frontend is wrapped in JSON."

# Update TerminalComponent.jsx
cat > ./src/frontend/components/terminal/TerminalComponent.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { setupXTerm } from '../../service/terminal/setupXTerm';
import DetailsComponent from '../DetailsComponent';

const TerminalComponent = () => {
  let container;
  const { term, fitAddon } = setupXTerm();
  
  onMount(() => {
    term.open(container);
    fitAddon.fit();

    const { rows, cols } = term;
    terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'resize', rows, cols }));

    terminalConnection.setOnDataReceived((data) => {
      term.write(data);
    });

    term.onData((data) => {
      terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'input', data }));
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

# Update setupTerminalServer.js
cat > ./src/backend/terminal/setupTerminalServer.js << 'EOF'
import os from 'os';
import pty from 'node-pty';

export default function setupTerminalServer(socket) {
  const defaultShell = process.env.SHELL || '/bin/sh';
  const shell = os.platform() === 'win32' ? 'powershell.exe' : defaultShell;
  const terminal = pty.spawn(shell, [], {
    name: 'xterm-color',
    env: process.env,
  });

  socket.on('message', (data) => {
    const parsedData = JSON.parse(data);

    if (parsedData.type === 'resize') {
      terminal.resize(parsedData.cols, parsedData.rows);
    } else if (parsedData.type === 'input') {
      terminal.write(parsedData.data);
    }
  });

  terminal.on('data', (data) => {
    socket.send(data);
  });

  terminal.on('exit', () => {
    socket.close();
  });
}
EOF

echo "\033[32mDone: $goal\033[0m\n"