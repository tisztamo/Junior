#!/bin/sh
set -e

goal="Refactor directory structure, imports and package.json"
echo "Plan:"
echo "1. Move bin scripts from src/ to scripts/"
echo "2. Remove duplicate rollback functionality"
echo "3. Update relative imports in moved files"
echo "4. Update paths in package.json"

# 1. Move bin scripts from src/ to scripts/
mv ./src/main.js ./scripts/main.js
mv ./src/web.js ./scripts/web.js
mv ./src/junior-rollback.js ./scripts/junior-rollback.js
mv ./src/init.js ./scripts/init.js

# 2. Remove duplicate rollback functionality (from scripts/)
rm ./scripts/rollbackCommand.js

# 3. Update relative imports in moved files

# Update imports for main.js
cat > ./scripts/main.js << 'EOF'
#!/usr/bin/env node

import { startInteractiveSession } from '../src/interactiveSession/startInteractiveSession.js';
import { getApi, get_model, rl } from '../src/config.js';

(async () => {
  console.log("Welcome to Junior. Model: " + get_model() + "\n");
  const api = await getApi();
  startInteractiveSession(rl, api);
})();

export { startInteractiveSession };
EOF

# Update imports for web.js
cat > ./scripts/web.js << 'EOF'
#!/usr/bin/env node
import { startServer } from '../src/backend/startServer.js';
import { startVite } from '../src/frontend/startVite.js';

startServer();
startVite();
EOF

# Update imports for init.js
cat > ./scripts/init.js << 'EOF'
#!/usr/bin/env node
import { fileURLToPath } from 'url';
import createGitignore from '../src/git/createGitignore.js';
import { createPromptYaml } from '../src/prompt/createPromptYaml.js';
import { createPromptDir } from '../src/prompt/createPromptDir.js';
import copyDefaults from '../src/command/init/copyDefaults.js';
import checkAndInitRepo from '../src/git/checkAndInitRepo.js';
import commitGit from '../src/git/commitGit.js';
import path from 'path';
import isRepoClean from '../src/git/isRepoClean.js';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function juniorInit() {
  await checkAndInitRepo();

  if (!await isRepoClean()) {
    console.error("\x1b[31mDirectory is not clean. Please commit or stash changes and try again.\x1b[0m");
    process.exit(1);
  }

  createGitignore();
  await createPromptDir();
  createPromptYaml();

  const defaultsPath = path.join(__dirname, '../src/prompt/defaults');
  await copyDefaults(defaultsPath, './prompt/');

  await commitGit("Junior init");

  console.log('\x1b[32mRepo initialized for Junior development\x1b[0m');
}

juniorInit();
EOF

# 4. Update paths in package.json
jq '.bin.junior = "scripts/main.js" | .bin["junior-web"] = "scripts/web.js" | .bin["junior-init"] = "scripts/init.js" | .bin["junior-rollback"] = "scripts/junior-rollback.js"' package.json > package.tmp.json && mv package.tmp.json package.json

echo "\033[32mDone: $goal\033[0m\n"