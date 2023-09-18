#!/bin/sh
set -e
goal="Implement terminal WebSocket communication"
echo "Plan:"
echo "1. Create terminalConnection.js to handle WebSocket communication with /terminal"
echo "2. Update TerminalComponent.jsx to use the new service"

# 1. Create terminalConnection.js
mkdir -p ./src/frontend/service/terminal/
cat > ./src/frontend/service/terminal/terminalConnection.js << 'EOF'
import { createWebSocket } from '../createWebSocket';

const socket = createWebSocket();

const sendDataToTerminal = (data) => {
  if (socket.readyState === WebSocket.OPEN) {
    socket.send(data);
  }
};

const setOnDataReceived = (callback) => {
  socket.onmessage = (event) => {
    callback(event.data);
  };
};

const closeConnection = () => {
  if (socket.readyState === WebSocket.OPEN) {
    socket.close();
  }
};

export default {
  sendDataToTerminal,
  setOnDataReceived,
  closeConnection,
};
EOF

# 2. Update TerminalComponent.jsx to use the new service
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
    <div class="rounded border p-4" ref={container}>
      {/* The terminal will be rendered inside this div */}
    </div>
  );
};

export default TerminalComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"