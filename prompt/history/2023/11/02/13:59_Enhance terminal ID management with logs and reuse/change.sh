#!/bin/sh
set -e
goal="Enhance terminal ID management with logs and reuse"
echo "Plan:"
echo "1. Amend setupTerminalServer.js to send a disconnect log to the old socket."
echo "2. Reuse the existing terminal if available and log the action to the console."
cat > ./src/backend/terminal/setupTerminalServer.js << 'EOF'
import os from 'os';
import pty from 'node-pty';

const terminals = {};

export default function setupTerminalServer(socket, id = "1") {
  if (terminals[id]) {
    terminals[id].socket.send('\x1b[33mThis terminal was disconnected in favor of another connection. Reload Junior to take it back.\x1b[0m');
    terminals[id].socket.close();
    console.log(`Reusing terminal for id: ${id}`);
  } else {
    const defaultShell = process.env.SHELL || '/bin/sh';
    const shell = os.platform() === 'win32' ? 'powershell.exe' : defaultShell;
    const terminal = pty.spawn(shell, [], {
      name: 'xterm-color',
      env: process.env,
    });

    terminal.on('data', (data) => {
      socket.send(data);
    });

    terminal.on('exit', () => {
      socket.close();
      delete terminals[id];
    });

    terminals[id] = { terminal, socket };
    console.log(`Created new terminal for id: ${id}`);
  }

  socket.on('message', (data) => {
    const parsedData = JSON.parse(data);

    if (parsedData.type === 'resize') {
      terminals[id].terminal.resize(parsedData.cols, parsedData.rows);
    } else if (parsedData.type === 'input') {
      terminals[id].terminal.write(parsedData.data);
    }
  });

  terminals[id].socket = socket;
}
EOF
echo "\033[32mDone: $goal\033[0m\n"