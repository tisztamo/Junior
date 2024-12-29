#!/bin/sh
set -e
goal="Refactor virtual key bindings & update hover color"
echo "Plan:"
echo "1. Create frontend/config/terminalVirtualKeyBindings.js with virtual key bindings configuration."
echo "2. Refactor TerminalComponent.jsx to utilize the new configuration."
echo "3. Update the hover color in VirtualButton.jsx."

# 1. Create terminalVirtualKeyBindings.js with virtual key bindings configuration.
cat > ./src/frontend/config/terminalVirtualKeyBindings.js << 'EOF'
const terminalVirtualKeyBindings = () => {
  return [
    { label: 'Esc', action: '\x1B' },
    { label: '-', action: '-' },
    { label: ':', action: ':' },
    { label: 'Ctrl-Z', action: '\x1A' },
    { label: 'Ctrl-Y', action: '\x19' },
    { label: 'Ctrl-X', action: '\x18' },
    { label: 'Ctrl-V', action: '\x16' },
    { label: 'F1', action: '\x1BOP' },
    { label: 'F5', action: '\x1B[15~' },
    { label: 'F6', action: '\x1B[17~' },
    { label: 'F7', action: '\x1B[18~' }
  ];
};

export default terminalVirtualKeyBindings;
EOF

# 2. Refactor TerminalComponent.jsx to utilize the new configuration.
cat > ./src/frontend/components/terminal/TerminalComponent.jsx << 'EOF'
import { onCleanup, onMount } from 'solid-js';
import 'xterm/css/xterm.css';
import terminalConnection from '../../service/terminal/terminalConnection';
import { setupXTerm } from '../../service/terminal/setupXTerm';
import { sendTerminalResizeNotification } from '../../service/terminal/sendTerminalResizeNotification';
import DetailsComponent from '../DetailsComponent';
import VirtualButton from './VirtualButton';
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
      <div class="flex overflow-x-auto whitespace-nowrap">
        {terminalVirtualKeyBindings().map(({ label, action }) => (
          <VirtualButton label={label} action={() => sendVirtualKey(action)} />
        ))}
      </div>
      <div ref={container}>
        {/* The terminal will be rendered inside this div */}
      </div>
    </DetailsComponent>
  );
};

export default TerminalComponent;
EOF

# 3. Update the hover color in VirtualButton.jsx.
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
      className="text-text m-1 bg-main hover:bg-blue-500 font-bold py-1 px-2 rounded"
      onClick={sendKey}
    >
      {props.label}
    </button>
  );
};

export default VirtualButton;
EOF

echo "\033[32mDone: $goal\033[0m\n"