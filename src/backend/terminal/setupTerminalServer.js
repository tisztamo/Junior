import { spawn } from 'child_process';

export default function setupTerminalServer(socket) {
  const shell = spawn('/bin/sh');

  socket.on('data', (data) => {
    shell.stdin.write(data);
  });

  shell.stdout.on('data', (data) => {
    socket.write(data);
  });

  shell.stderr.on('data', (data) => {
    socket.write(data);
  });

  shell.on('exit', () => {
    socket.end();
  });
}
