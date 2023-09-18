#!/bin/sh
set -e

goal="Implement hostConfig for centralized --host logic"
echo "Plan:"
echo "1. Create the src/config/ directory."
echo "2. Create a new file src/config/hostConfig.js to centralize the --host logic."
echo "3. Modify src/backend/startServer.js to use the hostConfig."
echo "4. Modify src/frontend/startVite.js to use the hostConfig."

# Step 1: Create the src/config/ directory
mkdir -p src/config

# Step 2: Create src/config/hostConfig.js
cat > src/config/hostConfig.js << 'EOF'
import process from 'process';

export default function hostConfig() {
  const hostArg = process.argv.find(arg => arg.startsWith('--host'));

  if (!hostArg) {
    return { enabled: false };
  }

  if (hostArg === '--host') {
    return { enabled: true };
  }

  const ip = hostArg.split('=')[1];
  return { enabled: true, ip };
}
EOF

# Step 3: Modify src/backend/startServer.js
cat > src/backend/startServer.js << 'EOF'
import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { setupRoutes } from './setupRoutes.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';
import { getServerPort } from './serverConfig.js';
import hostConfig from '../config/hostConfig.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);
  const wss = new WebSocketServer({ server });

  notifyOnFileChange(wss);

  setupRoutes(app);

  const { enabled, ip } = hostConfig();

  const port = getServerPort();
  server.listen(port, ip || (enabled ? '0.0.0.0' : undefined), () => {
    console.log('Server is running on port', port);
  });
}
EOF

# Step 4: Modify src/frontend/startVite.js
cat > src/frontend/startVite.js << 'EOF'
import path from 'path';
import { fileURLToPath } from 'url';
import { createServer } from 'vite';
import hostConfig from '../config/hostConfig.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export async function startVite() {
  const { enabled, ip } = hostConfig();

  if (enabled) {
    console.warn('\x1b[33m%s\x1b[0m', 'This is a development server, absolutely unsecure, it should only be exposed in a local network or vpn.');
  }

  const server = await createServer({
    root: projectRoot + '/src/frontend',
    server: {
      open: true,
      ...(enabled ? { host: ip || true } : {})
    },
  });
  await server.listen();
  server.printUrls();
}
EOF

echo "\033[32mDone: $goal\033[0m\n"