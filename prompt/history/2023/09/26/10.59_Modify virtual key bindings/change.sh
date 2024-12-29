#!/bin/sh
set -e
goal="Modify virtual key bindings"
echo "Plan:"
echo "1. Remove key bindings for '-' and ':'."
echo "2. Add 'Tab' key binding as the first one."

cat > ./src/frontend/config/terminalVirtualKeyBindings.js << 'EOF'
const terminalVirtualKeyBindings = () => {
  return [
    { label: 'Tab', action: '\t' },
    { label: 'Esc', action: '\x1B' },
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