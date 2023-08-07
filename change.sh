#!/bin/sh
set -e
goal="Update roadmap with completion marker"
echo "Plan:"
echo "1. Add a unicode character and a word to signify the completion of 'Implement the four buttons' in the roadmap."
cat > docs/roadmap.md << 'EOF'
# Roadmap
## Usability & fixes
- ✅ Done: Implement the four buttons
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
echo "\033[32mDone: $goal\033[0m\n"
