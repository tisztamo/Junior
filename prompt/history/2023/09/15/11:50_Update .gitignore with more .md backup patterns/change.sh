#!/bin/sh
set -e
goal="Update .gitignore with more .md backup patterns"
echo "Plan:"
echo "1. Append various .md backup patterns to .gitignore file, starting with a new line."

cat >> ./.gitignore << 'EOF'

# Backup patterns for .md files
*.md.backup
*.md.bak
*.md~
*.md.tmp
*.md.old
*.md.orig
*.md.save
EOF

echo "\033[32mDone: $goal\033[0m\n"
