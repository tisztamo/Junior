#!/bin/sh

# Goal: Rename project to Junior
# Plan:
# 1. Update package.json
# 2. Update README.md
# 3. Scan the source code files in the ./src directory recursively and replace old package name with the new one where found.

# Step 1: Update package.json
tmp_package_json=$(mktemp)
jq '.name="@aijunior/dev" | .repository.url="git+https://github.com/tisztamo/Junior.git" | .bugs.url="https://github.com/tisztamo/Junior/issues" | .homepage="https://github.com/tisztamo/Junior#readme"' package.json > "$tmp_package_json" && mv "$tmp_package_json" package.json

# Step 2: Update README.md
sed -i '' 's/The Contributor - Your AI contributor which writes itself./The Junior - Your AI Junior which writes itself./g' README.md

# Step 3: Scan source code and replace old package name
find ./src -name '*.js' -print0 | while IFS= read -r -d '' file
do
    sed -i '' 's#@aijunior/contributor#@aijunior/dev#g' "$file"
done
