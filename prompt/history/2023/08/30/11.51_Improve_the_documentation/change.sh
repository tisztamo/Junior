#!/bin/sh
set -e
goal="Improve the documentation"
echo "Plan:"
echo "1. Rename the cover-color classes in styles.css and _coverpage.md."
echo "2. Add a class for the missing green color in styles.css."
echo "3. Make the colors in the cover classes !important in styles.css."
echo "4. Merge 'codes' with 'Junior' and set its color to orange in _coverpage.md."

# Step 1: Rename the cover-color classes in styles.css and _coverpage.md.
cat > docs/assets/styles.css << 'EOF'
.app-name-link img {
  max-width: 70px;
}

iframe {
  margin: 16px;
}

/* Adding logo colors to cover page */
.cover-color-blue {
  color: rgb(59, 130, 246) !important;
}

.cover-color-orange {
  color: rgb(253, 186, 116) !important;
}

.cover-color-red {
  color: rgb(185, 28, 28) !important;
}
EOF

cat > docs/_coverpage.md << 'EOF'
# <span class="cover-color-blue">You are the Pro,</span> <span class="cover-color-orange">Junior&nbsp;codes</span>

Welcome to **Junior**, your AI-first IDE.

![](assets/logo.svg)

EOF

# Step 2: Add a class for the missing green color in styles.css.
echo ".cover-color-green {" >> docs/assets/styles.css
echo "  color: rgb(21, 128, 61) !important;" >> docs/assets/styles.css
echo "}" >> docs/assets/styles.css

# Steps 3 and 4 are already addressed in previous commands.

echo "\033[32mDone: $goal\033[0m\n"