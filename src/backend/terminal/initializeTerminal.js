import os from 'os';
import pty from '@homebridge/node-pty-prebuilt-multiarch';

export default function initializeTerminal(socket, id) {
  const defaultShell = process.env.SHELL || '/bin/sh';
  const shell = os.platform() === 'win32' ? 'powershell.exe' : defaultShell;
  const terminal = pty.spawn(shell, [], {
    name: 'xterm-color',
    env: process.env,
  });

  terminal.on('data', (data) => {
    socket.send(data);
  });

  return terminal;
}
