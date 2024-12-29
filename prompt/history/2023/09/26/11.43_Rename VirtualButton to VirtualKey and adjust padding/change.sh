#!/bin/sh
set -e
goal="Rename VirtualButton to VirtualKey and adjust padding"
echo "Plan:"
echo "1. Rename VirtualButton.jsx to VirtualKey.jsx"
echo "2. Update the contents of VirtualKey.jsx to reflect the new name and adjust padding"
echo "3. Update the TerminalComponent.jsx to use the new VirtualKey component name and file"

# Step 1: Rename VirtualButton.jsx to VirtualKey.jsx
mv ./src/frontend/components/terminal/VirtualButton.jsx ./src/frontend/components/terminal/VirtualKey.jsx

# Step 2: Update the contents of VirtualKey.jsx
cat > ./src/frontend/components/terminal/VirtualKey.jsx << 'EOF'
import { createSignal } from 'solid-js';

const VirtualKey = (props) => {
  const sendKey = () => {
    if (props.action) {
      props.action();
    }
  };

  return (
    <button
      className="text-text m-1 bg-main hover:bg-blue-500 font-bold py-2 px-3 rounded" 
      onClick={sendKey}
    >
      {props.label}
    </button>
  );
};

export default VirtualKey;
EOF

# Step 3: Update TerminalComponent.jsx to reflect the new changes
cat > ./src/frontend/components/terminal/TerminalComponent.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { setupXTerm } from '../../service/terminal/setupXTerm';
import { sendTerminalResizeNotification } from '../../service/terminal/sendTerminalResizeNotification';
import DetailsComponent from '../DetailsComponent';
import VirtualKey from './VirtualKey';
import terminalVirtualKeyBindings from '../../config/terminalVirtualKeyBindings';

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