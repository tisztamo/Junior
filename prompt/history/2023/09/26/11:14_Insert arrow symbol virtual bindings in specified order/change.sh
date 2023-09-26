#!/bin/sh
set -e

goal="Insert arrow symbol virtual bindings in specified order"
echo "Plan:"
echo "1. Modify terminalVirtualKeyBindings.js to add arrow symbols (Left, Up, Down, Right) as virtual bindings."
echo "2. Place them immediately after the 'Esc' key binding in the specified sequence."

cat > ./src/frontend/config/terminalVirtualKeyBindings.js << 'EOF'
const terminalVirtualKeyBindings = () => {
  return [
    { label: 'Tab', action: '\t' },
    { label: 'Esc', action: '\x1B' },
    { label: '←', action: '\x1B[D' },
    { label: '↑', action: '\x1B[A' },
    { label: '↓', action: '\x1B[B' },
    { label: '→', action: '\x1B[C' },
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

echo "\033[32mDone: $goal\033[0m\n"