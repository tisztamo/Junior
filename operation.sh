#!/bin/bash

# Step 1: Rename files
mv ./current_prompt.yaml ./prompt.yaml
mv ./current_prompt.md ./prompt.md

# Step 2: Update dependencies
sed -i '' -e 's/current_prompt\.yaml/prompt.yaml/g' ./src/prompt/createPrompt.js
sed -i '' -e 's/current_prompt\.md/prompt.md/g' ./src/prompt/processPrompt.js

echo "Files renamed and dependencies updated successfully."
