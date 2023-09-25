import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { initializeXTerm } from '../../service/terminal/setupXTerm';
import DetailsComponent from '../DetailsComponent';

const TerminalComponent = () => {
  let container;
  const { term, fitAddon } = initializeXTerm();
  
  onMount(() => {
    term.open(container);
    fitAddon.fit();

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
    <DetailsComponent 
      defaultState="closed"
      localStorageKey="terminalState"
      generateHeader={() => "Terminal"}
      classes="rounded border p-2 w-full"
    >
      <div ref={container}>
        {/* The terminal will be rendered inside this div */}
      </div>
    </DetailsComponent>
  );
};

export default TerminalComponent;
