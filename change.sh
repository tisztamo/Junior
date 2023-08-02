#!/bin/sh
set -e
goal="Improve documentation and roadmap"
echo "Plan:"
echo "1. Update the roadmap with the provided details."
echo "2. Save changes to doc/roadmap.md."
echo "3. Build the documentation using npm."

cat > doc/roadmap.md << 'EOF'
# Roadmap
## Usability & fixes
- Implement the four buttons
- Fix every major bug
- Write docs to allow using Junior for developing external projects

## Programming on mobile
- Develop a file browser to allow the user to select attention files from mobile
- Create an app by wrapping the frontend
- Test it by developing at the local Playground and while commuting

## Auto-attention
- Propose an attention based on the requirements and task the user selected
- Embed every file in the project
- Store the embeddings in an (embedded) vector database

## Prompt herds
- Scan and transform (refactor) the codebase gradually
EOF

npm run build:doc

echo "\033[32mDone: $goal\033[0m\n"
