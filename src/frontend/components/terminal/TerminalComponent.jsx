import { onCleanup, onMount } from 'solid-js';
import { Terminal } from 'xterm';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';

const TerminalComponent = () => {
  let container;
  const term = new Terminal();
  
  onMount(() => {
    term.open(container);

    terminalConnection.setOnDataReceived((data) => {
      term.write(data);
    });

    term.onData((data) => {
      terminalConnection.sendDataToTerminal(data);
    });
  });
  
  // Ensure terminal instance gets destroyed and WebSocket connection gets closed on component cleanup
  onCleanup(() => {
    term.dispose();
    terminalConnection.closeConnection();
  });

  return (
    <div class="rounded border p-4" ref={container}>
      {/* The terminal will be rendered inside this div */}
    </div>
  );
};

export default TerminalComponent;
