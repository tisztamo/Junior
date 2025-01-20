import os from 'os';
import pty from '@homebridge/node-pty-prebuilt-multiarch';
import initializeTerminal from './initializeTerminal.js';

const terminals = {};

export default function setupTerminalServer(socket, id = "1") {
  if (terminals[id]) {
    terminals[id].socket.send('\x1b[33mThis terminal was disconnected in favor of another connection. Reload Junior to take it back.\x1b[0m ');
    terminals[id].socket.close();
    console.log(`Reusing terminal for id: ${id}`);

    // Update terminal data event handler to send data to the new socket
    terminals[id].terminal.removeAllListeners('data');
    terminals[id].terminal.on('data', (data) => {
      terminals[id].socket.send(data);
    });

    // Send notice to the newly connected socket after a short delay and reset color after dollar sign
    setTimeout(() => {
      terminals[id].socket.send('\x1b[33mTerminal is reused, history is not copied.  \x1b[0m\x1b[33munknown shell $ \x1b[0m');
    }, 100);
  } else {
    terminals[id] = { terminal: initializeTerminal(socket, id), socket };
    console.log(`Created new terminal for id: ${id}`);
  }

  terminals[id].terminal.on('exit', () => {
    // Do not close the socket; instead, restart the terminal
    terminals[id].terminal = initializeTerminal(terminals[id].socket, id);
    console.log(`Restarted terminal for id: ${id}`);
  });

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
