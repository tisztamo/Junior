#!/bin/sh
# Goal: Scaffold a vscode extension
# Plan:
# 1. Install Yeoman and VS Code Extension generator globally.
# 2. Use the generator to create the VS Code extension in the desired directory.

# Step 1: Install Yeoman and VS Code Extension generator globally
npm install -g yo generator-code

# Step 2: Use the generator to create the VS Code extension in the desired directory
mkdir -p src/integrations
cd src/integrations
yo code

# Note: Running "yo code" will prompt a series of questions to configure your extension. Please follow the instructions.

#!/bin/sh
# Goal: Add .gitignore file to vscode extension
# Plan:
# 1. Add a .gitignore file in src/integrations/vscode directory

# Step 1: Add a .gitignore file in src/integrations/vscode directory
cat > src/integrations/vscode/.gitignore <<- EOM
node_modules
out
*.vsix
.vscode-test
EOM
