#!/bin/sh
set -e
goal="Implement terminal server ID management"
echo "Plan:"
echo "1. Update setupTerminalServer.js to accept an id parameter and store terminals and sockets in a dictionary."
echo "2. Modify the handling of new connections to check for existing ids and close previous sockets if necessary."
cat > ./src/backend/terminal/setupTerminalServer.js << 'EOF'
import os from 'os';
import pty from 'node-pty';

const terminals = {};

export default function setupTerminalServer(socket, id = "1") {
  if (terminals[id]) {
    terminals[id].socket.close();
  }

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
    delete terminals[id];
  });

  terminals[id] = { terminal, socket };
}
EOF
echo "\033[32mDone: $goal\033[0m\n"