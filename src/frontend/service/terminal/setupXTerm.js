import { Terminal } from 'https://cdn.jsdelivr.net/npm/xterm@5.3.0/+esm';
import { FitAddon } from './fitAddOn';

export function setupXTerm() {
  const term = new Terminal();
  const fitAddon = FitAddon();
  term.loadAddon(fitAddon);
  
  return { term, fitAddon };
}
