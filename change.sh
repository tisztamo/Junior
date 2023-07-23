#!/bin/sh
# Goal: Move .js files from doc to src/doc and update package.json accordingly
# Plan:
# 1. Create the src/doc directory if it doesn't exist.
# 2. Move all .js files from doc to src/doc using the mv command. 
# 3. Update the script command in package.json to refer to the new location.
#    a. Use jq to perform the package.json update. 
# 4. Assumption: there are no name conflicts in src/doc and we do not overwrite existing files.


# Create the target directory if it does not exist
mkdir -p ./src/doc

# Move all JavaScript files
mv ./doc/*.js ./src/doc/

# Update the "build:docs" line in package.json
jq '.scripts["build:docs"] = "node ./src/doc/buildDoc.js"' package.json > package.temp.json && mv package.temp.json package.json
