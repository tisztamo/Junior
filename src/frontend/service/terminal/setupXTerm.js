import { Terminal } from 'xterm';
import { FitAddon } from './fitAddOn';

export function setupXTerm() {
  const term = new Terminal();
  const fitAddon = FitAddon();
  term.loadAddon(fitAddon);
  
  return { term, fitAddon };
}
