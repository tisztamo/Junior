#!/bin/sh
set -e
goal="Refocus terminal and update button style"
echo "Plan:"
echo "1. Modify VirtualButton.jsx to remove 'text-white' class."
echo "2. After sending the virtual key, shift the focus back to the terminal."
echo "3. Ensure all changes maintain single export per file rule."

# Step 1: Modify VirtualButton.jsx
cat > ./src/frontend/components/terminal/VirtualButton.jsx << 'EOF'
import { createSignal } from 'solid-js';

const VirtualButton = (props) => {
  const sendKey = () => {
    if (props.action) {
      props.action();
    }
  };

  return (
    <button
      className="text-text m-1 bg-main hover:bg-blue-700 font-bold py-1 px-2 rounded"
      onClick={sendKey}
    >
      {props.label}
    </button>
  );
};

export default VirtualButton;
EOF

# Step 2: Modify TerminalComponent.jsx to refocus terminal
cat > ./src/frontend/components/terminal/TerminalComponent.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { setupXTerm } from '../../service/terminal/setupXTerm';
import { sendTerminalResizeNotification } from '../../service/terminal/sendTerminalResizeNotification';
import DetailsComponent from '../DetailsComponent';
import VirtualButton from './VirtualButton';

const TerminalComponent = () => {
  let container;
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
    });

    term.onData((data) => {
      terminalConnection.sendDataToTerminal(JSON.stringify({ type: 'input', data }));
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
      generateHeader={() => "Terminal"}
      classes="rounded border p-2 w-full border-border bg-emphasize"
    >
      <div class="flex overflow-x-auto whitespace-nowrap">
        <VirtualButton label="Esc" action={() => sendVirtualKey('\x1B')} />
        <VirtualButton label="-" action={() => sendVirtualKey('-')} />
        <VirtualButton label=":" action={() => sendVirtualKey(':')} />
        <VirtualButton label="Ctrl-Z" action={() => sendVirtualKey('\x1A')} />
        <VirtualButton label="Ctrl-Y" action={() => sendVirtualKey('\x19')} />
        <VirtualButton label="Ctrl-X" action={() => sendVirtualKey('\x18')} />
        <VirtualButton label="Ctrl-V" action={() => sendVirtualKey('\x16')} />
        <VirtualButton label="F1" action={() => sendVirtualKey('\x1BOP')} />
        <VirtualButton label="F5" action={() => sendVirtualKey('\x1B[15~')} />
        <VirtualButton label="F6" action={() => sendVirtualKey('\x1B[17~')} />
        <VirtualButton label="F7" action={() => sendVirtualKey('\x1B[18~')} />
      </div>
      <div ref={container}>
        {/* The terminal will be rendered inside this div */}
      </div>
    </DetailsComponent>
  );
};

export default TerminalComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"