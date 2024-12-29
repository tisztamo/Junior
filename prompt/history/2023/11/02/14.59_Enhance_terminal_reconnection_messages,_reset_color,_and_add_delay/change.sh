#!/bin/sh
set -e
goal="Enhance terminal reconnection messages, reset color, and add delay"
echo "Plan:"
echo "1. Modify setupTerminalServer.js to add a newline before disconnection notice."
echo "2. Send a yellow notice with instructions to the newly connected socket after a short delay."
echo "3. Ensure newline and yellow prompt \"unknown shell $ \" are added, then reset color."

cat > ./src/backend/terminal/setupTerminalServer.js << 'EOF'
import os from 'os';
import pty from 'node-pty';

const terminals = {};

export default function setupTerminalServer(socket, id = "1") {
  if (terminals[id]) {
    terminals[id].socket.send('\n\x1b[33mThis terminal was disconnected in favor of another connection. Reload Junior to take it back.\x1b[0m\n');
    terminals[id].socket.close();
    console.log(`Reusing terminal for id: ${id}`);

    // Update terminal data event handler to send data to the new socket
    terminals[id].terminal.removeAllListeners('data');
    terminals[id].terminal.on('data', (data) => {
      socket.send(data);
    });

    // Send notice to the newly connected socket after a short delay and reset color after dollar sign
    setTimeout(() => {
      socket.send('\n\x1b[33mNotice: Terminal is reused, history is not copied.\x1b[0m\n\x1b[33munknown shell $ \x1b[0m');
    }, 100);
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

  // Update the socket reference in the terminals dictionary
  terminals[id].socket = socket;
}
EOF

echo "\033[32mDone: $goal\033[0m\n"