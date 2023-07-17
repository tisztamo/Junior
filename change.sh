#!/bin/sh

# Goal: Make "npx junior-web" start web.js
# Plan:
# 1. Modify package.json to add "junior-web" command to the bin object and change the "start" script.
# 2. Add shebang to web.js.
# 3. Make web.js executable.

# Step 1: Modify package.json
jq '.bin += {"junior-web": "src/web.js"} | .scripts.start = "node src/web.js"' package.json > package.json.tmp && mv package.json.tmp package.json

# Step 2: Add shebang to web.js
echo '#!/usr/bin/env node' | cat - src/web.js > temp && mv temp src/web.js

# Step 3: Make web.js executable
chmod +x src/web.js

#!/bin/sh

# Goal: Fix "vite: command not found" error when run from another project
# Plan:
# 1. Modify the command in startVite.js to use the local version of vite in this project.

# Step 1: Modify startVite.js
cat << 'EOF' > src/startVite.js
import { exec } from 'child_process';
import path from 'path';

export function startVite() {
  const projectRoot = path.resolve(__dirname, '..');
  const vite = exec(\`$${projectRoot}/node_modules/.bin/vite src --open\`);
  vite.stdout.pipe(process.stdout);
  vite.stderr.pipe(process.stderr);

  process.on('exit', () => vite.kill());
}
EOF
