#!/bin/sh
set -e
goal="Fix xterm import using CDN"
echo "Plan:"
echo "1. Modify setupXTerm.js to use CDN for xterm import"
cat > ./src/frontend/service/terminal/setupXTerm.js << 'EOF'
import { Terminal } from 'https://cdn.jsdelivr.net/npm/xterm@5.3.0/+esm';
import { FitAddon } from './fitAddOn';

export function setupXTerm() {
  const term = new Terminal();
  const fitAddon = FitAddon();
  term.loadAddon(fitAddon);
  
  return { term, fitAddon };
}
EOF
echo "\033[32mDone: $goal\033[0m\n"