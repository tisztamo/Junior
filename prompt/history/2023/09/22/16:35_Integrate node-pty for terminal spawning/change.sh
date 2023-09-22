#!/bin/sh
set -e
goal="Integrate node-pty for terminal spawning"
echo "Plan:"
echo "1. Install node-pty"
echo "2. Modify setupTerminalServer.js to use node-pty"
echo "3. Ensure cross-platform terminal spawning"
echo "4. Update terminal output and input handlers"

# 1. Install node-pty
echo "Installing node-pty..."
npm install node-pty

# 2. Modify setupTerminalServer.js to use node-pty
cat > ./src/backend/terminal/setupTerminalServer.js << 'EOF'
import os from 'os';
import pty from 'node-pty';

export default function setupTerminalServer(socket) {
  console.log("Setting up terminal server...");

  const shell = os.platform() === 'win32' ? 'powershell.exe' : '/bin/sh';
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