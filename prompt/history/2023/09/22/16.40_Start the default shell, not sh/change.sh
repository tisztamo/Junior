#!/bin/sh
set -e
goal="Start the default shell, not sh"
echo "Plan:"
echo "1. Modify setupTerminalServer.js to get the default shell from the ENV variable."
echo "2. Replace /bin/sh with the logic to fetch the default shell or fallback to /bin/sh."

cat > ./src/backend/terminal/setupTerminalServer.js << 'EOF'
import os from 'os';
import pty from 'node-pty';

export default function setupTerminalServer(socket) {
  console.log("Setting up terminal server...");

  const defaultShell = process.env.SHELL || '/bin/sh';
  const shell = os.platform() === 'win32' ? 'powershell.exe' : defaultShell;
  const terminal = pty.spawn(shell, [], {
    name: 'xterm-color',
    env: process.env,
  });

  socket.on('message', (data) => {
    console.log("Received message:", data.toString());
    terminal.write(data);
  });

  terminal.on('data', (data) => {
    console.log("Shell output:", data.toString());
    socket.send(data);
  });

  terminal.on('exit', () => {
    console.log("Shell exited");
    socket.close();
  });
}
EOF

echo "\033[32mDone: $goal\033[0m\n"