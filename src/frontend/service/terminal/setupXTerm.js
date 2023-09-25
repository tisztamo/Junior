import { Terminal } from 'xterm';
import { FitAddon } from 'xterm-addon-fit';

export function setupXTerm() {
  const term = new Terminal();
  const fitAddon = new FitAddon();
  term.loadAddon(fitAddon);
  
  return { term, fitAddon };
}
