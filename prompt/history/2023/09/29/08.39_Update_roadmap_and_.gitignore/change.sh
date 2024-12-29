#!/bin/sh
set -e
goal="Update roadmap and .gitignore"
echo "Plan:"
echo "1. Update the roadmap.md with the given requirements."
echo "2. Place the *_backup.md ignore pattern in the existing backup patterns section of .gitignore."

# Updating the roadmap.md file
cat > ./docs/roadmap.md << 'EOF'
# Roadmap

## Usability & fixes
`v0.2 (Released: Aug 2023)`
- ✅ Done: Implement the four buttons
- ✅ Done: Fix every major bug
- ✅ Done: Write docs to allow using Junior for developing external projects

## Programming on mobile
`v0.3 (Expected: Q4 2023)`
- 🚧 Develop a file browser to allow the user to select attention files from mobile (Ongoing)
- ✅ Done: Allow secure hosting
- Create an app by wrapping the frontend
- 🚧 Test it by developing at the local Playground and while commuting (Ongoing)

## Plugin system
`v0.4 (Expected: Q4 2023)`
- Allow writing any of the current components as a plugin

## Auto-attention
`v0.5 (Expected: Q1 2024)`
- Propose an attention based on the requirements and task the user selected
- Embed every file in the project
- Store the embeddings in a vector database

## Prompt herds
`v0.6 (Expected: Q2 2024)`
- Scan and transform (refactor) the codebase gradually
EOF

# Updating the .gitignore file with the backup pattern in the appropriate section
cat > ./.gitignore << 'EOF'
/secret.sh
/node_modules/
/tmp/
/prompt.yaml
/prompt.md
/change.sh

node_modules

# Backup patterns for .md files
*.md.backup
*.md.bak
*_backup.md
*.md~
*.md.tmp
*.md.old
*.md.orig
*.md.save
EOF

echo "\033[32mDone: $goal\033[0m\n"