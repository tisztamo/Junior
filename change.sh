#!/bin/sh
set -e
goal="Improve the documentation"
echo "Plan:"
echo "1. Update the language to reflect that the Web Interface is to automate changes with the help of the LLM"
echo "2. Change the button color description from green to blue for the Generate & Copy Prompt button"
echo "3. Run npm build:doc to generate the final document"

# Step 1: Update the language to reflect that the Web Interface is to automate changes with the help of the LLM
sed -i '' 's/guide the AI model/automate making changes with the help of the Language Learning Model (LLM)/' ./doc/web.md

# Step 2: Change the button color description from green to blue for the Generate & Copy Prompt button
sed -i '' 's/(Green)/(Blue)/' ./doc/web.md

# Step 3: Run npm build:doc to generate the final document
npm run build:doc

echo "\033[32mDone: $goal\033[0m\n"
