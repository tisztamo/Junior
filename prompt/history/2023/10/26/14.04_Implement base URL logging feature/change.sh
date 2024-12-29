#!/bin/sh
set -e
goal="Implement base URL logging feature"

cat > ./src/backend/getServerIPs.js << 'EOF'
import { networkInterfaces } from 'os';

export function getServerIPs() {
  const nets = networkInterfaces();
  const allIPs = [];

  for (const name of Object.keys(nets)) {
    for (const net of nets[name]) {
      if (net.family === 'IPv4' && !net.internal) {
        allIPs.push(net.address);
      }
    }
  }
  return allIPs;
}
EOF

cat > ./src/backend/logServerURLs.js << 'EOF'
import { getServerIPs } from './getServerIPs.js';

export function logServerURLs(enabled, ip, port) {
  const orange = "\x1b[38;5;214m";
  const reset = "\x1b[0m";
  const green = "\x1b[32m";
  
  console.log(`${green}Junior is accessible on the following urls:${reset}`);
  console.log();
  if (enabled && !ip) {
    const IPs = getServerIPs();
    IPs.forEach(address => {
        console.log(green, ' ⇒', orange, `http://${address}:${port}`, reset);
    });
  } else if (ip) {
    console.log(green, ' ⇒', orange, `http://${ip}:${port}`, reset);
  } else {
    console.log(green, ' ⇒', orange, `http://localhost:${port}`, reset);
    console.log("Note: Use --host or --host=IP to expose on the network.");
  }
  console.log();
}
EOF

cat > ./src/backend/serverSetup.js << 'EOF'
import getBackendPort from './getBackendPort.js';
import hostConfig from '../config/hostConfig.js';
import { logServerURLs } from './logServerURLs.js';

export function serverSetup(server) {
  const { enabled, ip } = hostConfig();
  const port = getBackendPort();
  
  server.listen(port, ip || (enabled ? '0.0.0.0' : undefined), () => {
    logServerURLs(enabled, ip, port);
  });
}
EOF

echo "\033[32mDone: $goal\033[0m\n"