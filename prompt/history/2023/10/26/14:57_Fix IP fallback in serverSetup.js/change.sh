#!/bin/sh
set -e
goal="Fix IP fallback in serverSetup.js"
echo "Plan:"
echo "1. Modify serverSetup.js to handle IP fallback scenario"

cat > ./src/backend/serverSetup.js << 'EOF'
import getBackendPort from './getBackendPort.js';
import hostConfig from '../config/hostConfig.js';
import { logServerURLs } from './logServerURLs.js';

export function serverSetup(server) {
  const { enabled, ip } = hostConfig();
  const port = getBackendPort();
  
  // If ip is defined, use it; otherwise, if enabled use '0.0.0.0'; if not enabled, use '127.0.0.1'.
  const listeningIP = ip || (enabled ? '0.0.0.0' : '127.0.0.1');

  server.listen(port, listeningIP, () => {
    logServerURLs(enabled, ip, port);
  });
}
EOF

echo "\033[32mDone: $goal\033[0m\n"