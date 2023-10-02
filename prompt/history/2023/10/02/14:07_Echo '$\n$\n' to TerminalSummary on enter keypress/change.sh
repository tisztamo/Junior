#!/bin/sh
set -e
goal="Echo '$\n$\n' to TerminalSummary on enter keypress"
echo "Plan:"
echo "1. Modify TerminalComponent.jsx to detect when the 'enter' key is pressed."
echo "2. Update the 'lastWritten' signal with the string '$\n$\n' when 'enter' is pressed to echo it to the TerminalSummary component."

# Detect 'enter' keypress in TerminalComponent.jsx and echo '$\n$\n'
cat > ./src/frontend/components/terminal/TerminalComponent.jsx << 'EOF'
import { onCleanup, onMount, createSignal } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { setupXTerm } from '../../service/terminal/setupXTerm';
import { sendTerminalResizeNotification } from '../../service/terminal/sendTerminalResizeNotification';
import DetailsComponent from '../DetailsComponent';
import VirtualKey from './VirtualKey';
import terminalVirtualKeyBindings from '../../config/terminalVirtualKeyBindings';
import { TerminalSummary } from './TerminalSummary';

const TerminalComponent = () => {
  let container;
  const [lastWritten, setLastWritten] = createSignal('');
  const { term, fitAddon } = setupXTerm();

  const sendVirtualKey = (key) => {
    terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'input', data: key }));
    term.focus();
  };

  onMount(() => {
    term.open(container);
    fitAddon.fit();

    const { rows, cols } = term;
    sendTerminalResizeNotification(rows, cols);

    terminalConnection.setOnDataReceived((data) => {
      term.write(data);
      setLastWritten(data); // Update the lastWritten signal on data receive
    });

    term.onData((data) => {
      terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'input', data }));
      if (data === '\r') { // Detect 'enter' keypress
        setLastWritten('$\n$\n'); // Echo '$\n$\n'
      }
    });

    term.onResize(({ newRows, newCols }) => {
      sendTerminalResizeNotification(newRows, newCols);
    });
  });
  
  onCleanup(() => {
    term.dispose();
    terminalConnection.closeConnection();
  });

  return (
    <DetailsComponent 
      defaultState="closed"
      localStorageKey="terminalState"
      generateHeader={() => <>Terminal <TerminalSummary lastWritten={lastWritten()} /></>}  // Use TerminalSummary here
      classes="rounded border p-2 w-full border-border bg-emphasize"
    >
      <div ref={container}></div>
      <div class="flex overflow-x-auto whitespace-nowrap">
        {terminalVirtualKeyBindings().map(({ label, action }) => (
          <VirtualKey label={label} action={() => sendVirtualKey(action)} />
        ))}
      </div>
    </DetailsComponent>
  );
};

export default TerminalComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"