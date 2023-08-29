#!/bin/sh
set -e
goal="Improve the documentation"
echo "Plan:"
echo "1. Rename cover.md to _coverpage.md"
echo "2. Add logo as background in the cover"

# Rename cover.md to _coverpage.md
mv docs/cover.md docs/_coverpage.md

# Add the logo to the end of the cover page
cat > docs/_coverpage.md << 'EOF'
# <span class="cover-color-1">You are the Pro,</span> <span class="cover-color-2">Junior</span> <span class="cover-color-3">codes</span>

Welcome to **Junior**, your AI-first IDE.

![](assets/logo.svg)
EOF

echo "\033[32mDone: $goal\033[0m\n"