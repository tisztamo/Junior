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
