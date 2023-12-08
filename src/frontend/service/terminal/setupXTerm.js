import { Terminal } from 'https://cdn.jsdelivr.net/npm/xterm@5.3.0/+esm';

export function setupXTerm() {
  const term = new Terminal({ rows: 24, cols: 80 });
  
  return { term };
}
