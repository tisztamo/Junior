#!/bin/sh
# Goal: Move 'glob' from devDependencies to dependencies in package.json
# Plan:
# 1. Remove 'glob' and '@types/glob' from devDependencies in package.json
# 2. Add 'glob' and '@types/glob' to dependencies in package.json

cd integrations/vscode

# Use 'jq' to remove 'glob' and '@types/glob' from devDependencies
jq 'del(.devDependencies["glob", "@types/glob"])' package.json > tmp.json && mv tmp.json package.json

# Use 'jq' to add 'glob' and '@types/glob' to dependencies
jq '.dependencies += {"glob": "^8.1.0", "@types/glob": "^8.1.0"}' package.json > tmp.json && mv tmp.json package.json
