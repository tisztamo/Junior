#!/bin/sh
set -e
goal="Fix npm ERR! notarget for docsify-cli@^4.4.7"
echo "Plan:"
echo "1. Find the package.json file"
echo "2. Check for docsify-cli version and edit it to latest available version"
echo "3. Save the file and commit the changes"

# Navigate to root directory
cd ./ 

# Use node to edit the package.json to set the docsify-cli version to the latest available version
node -e "
let package = require('./package.json');
package.dependencies['docsify-cli'] = '^4.4.4';
require('fs').writeFileSync('./package.json', JSON.stringify(package, null, 2));
"

# Add the change to git
git add package.json

# Commit the change
git commit -m "Fixing npm ERR! notarget for docsify-cli@^4.4.7, changed to version ^4.4.4"

echo "\033[32mDone: $goal\033[0m\n"
