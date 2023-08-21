#!/bin/sh
set -e

goal="Improve documentation"
echo "Plan:"
echo "1. Update the 'Usability & fixes' section in the roadmap to mark 'Fix every major bug' as completed."

cat > docs/roadmap.md << 'EOF'
# Roadmap
## Usability & fixes
- ✅ Done: Implement the four buttons
- ✅ Done: Fix every major bug
- ✅ Done: Write docs to allow using Junior for developing external projects

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