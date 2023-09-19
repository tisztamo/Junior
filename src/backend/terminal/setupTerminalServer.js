import { spawn } from 'child_process';

export default function setupTerminalServer(socket) {
  console.log("Setting up terminal server...");

  const shell = spawn('/bin/sh');

  socket.on('message', (data) => {
    console.log("Received message:", data.toString());
    shell.stdin.write(data);
  });

  shell.stdout.on('data', (data) => {
    console.log("Shell output:", data.toString());
    socket.send(data);
  });

  shell.stderr.on('data', (data) => {
    console.log("Shell error output:", data.toString());
    socket.send(data);
  });

  shell.on('exit', () => {
    console.log("Shell exited");
    socket.close();
  });
}
