#!/bin/sh
set -e
goal="Update package.json and scripts file structure"
echo "Plan:"
echo "1. Rename scripts/main.js to scripts/cli.js"
echo "2. Update package.json bin section to reflect the file name change and add new command"
echo "3. Update package.json scripts section to modify the existing command"

# Rename scripts/main.js to scripts/cli.js
mv ./scripts/main.js ./scripts/cli.js

# Update package.json using jq
jq ' .bin |= {
     "junior": "scripts/web.js",
     "junior-web": "scripts/web.js",
     "junior-cli": "scripts/cli.js",
     "junior-init": .["junior-init"],
     "junior-rollback": .["junior-rollback"],
     "junior-news": .["junior-news"]
     } |
     .scripts |= {
     "cli":"node scripts/cli.js",
     "start":"node scripts/web.js",
     "update-logo": .["update-logo"],
     "clear-branches": .["clear-branches"],
     "test": .test,
     "rollback": .rollback,
     "build:frontend": .["build:frontend"],
     "build:backend": .["build:backend"],
     "dev": .dev
     }' package.json > package.json.updated

# Move the updated package.json to the original location
mv package.json.updated package.json

echo "\033[32mDone: $goal\033[0m\n"