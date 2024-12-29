#!/bin/sh
set -e
goal="Refactor terminal backend and remove console logs"
echo "Plan:"
echo "1. Refactor setupTerminalServer.js by removing console logs."
echo "2. No changes needed for terminalRoutes.js as it has no console logs."
echo "3. Update the files with the refactored content."

# Refactor setupTerminalServer.js
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
    terminal.write(data);
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