#!/bin/sh
set -e
goal="Move vite config, startVite.js and index.html to src/frontend/"
echo "Plan:"
echo "1. Move the vite config, startVite.js and index.html files to the src/frontend/ directory."
echo "2. Update the import statements in web.js to point to the new location of startVite.js"
echo "3. Update the script source in index.html to keep it working."
echo "4. Update the projectRoot in startVite.js to reflect the new location."
echo "5. Update the path in the exec command in startVite.js to reflect the new file locations."

# Step 1: Moving vite config, startVite.js and index.html to src/frontend/

cat << 'EOF' > src/frontend/vite.config.js
import { defineConfig } from 'vite'
import solidPlugin from 'vite-plugin-solid'

export default defineConfig({
  plugins: [solidPlugin()],
  css: {
    postcss: './src/frontend/postcss.config.cjs'
  },
  build: {
    target: 'esnext',
  },
})
EOF

# Step 4: Updating projectRoot in startVite.js

cat << 'EOF' > src/frontend/startVite.js
import { exec } from 'child_process';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export function startVite() {
  const vite = exec(`${projectRoot}/node_modules/.bin/vite ${projectRoot}/src/frontend --open`);
  vite.stdout.pipe(process.stdout);
  vite.stderr.pipe(process.stderr);

  process.on('exit', () => vite.kill());
}
EOF

cat << 'EOF' > src/frontend/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>Junior</title>
</head>
<body>
  <div id="app"></div>
  <script type="module" src="/frontend/index.jsx"></script>
</body>
</html>
EOF

# Step 2: Updating web.js

cat << 'EOF' > src/web.js
#!/usr/bin/env node
import { startServer } from './backend/startServer.js';
import { startVite } from './frontend/startVite.js';

startServer();
startVite();
EOF

# Step 3: Updating index.html

cat << 'EOF' > src/frontend/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>Junior</title>
</head>
<body>
  <div id="app"></div>
  <script type="module" src="/index.jsx"></script>
</body>
</html>
EOF

# Remove old files
rm src/vite.config.js
rm src/startVite.js
rm src/index.html

echo "\033[32mDone: $goal\033[0m\n"
