#!/bin/sh
set -e
goal="Refine EJS root and views configuration"
echo "Plan:"
echo "1. Update the ejsConfig.js to refine root and views settings."

# 1. Update the ejsConfig.js to refine root and views settings.
cat > ./src/prompt/ejsConfig.js << 'EOF'
import getProjectRoot from '../backend/fileutils/getProjectRoot.js';
import { cwd } from 'process';

const projectRoot = getProjectRoot();
const currentDir = cwd();

const ejsConfig = {
    async: false,
    root: [currentDir, projectRoot], 
    views: [currentDir, projectRoot]
};

export default ejsConfig;
EOF

echo "\033[32mDone: $goal\033[0m\n"