#!/bin/sh
set -e
goal="Improve documentation with cover page"
echo "Plan:"
echo "1. Create a new cover.md file to serve as the cover page for the documentation."
echo "2. Update docsifyConfig.js to enable the cover page feature."
echo "3. Update styles.css to include styles corresponding to the logo colors for the cover page."
echo "4. Use the new classes in the cover.md file."

# Step 1: Create cover.md file with the main message.
cat > ./docs/cover.md << 'EOF'
# <span class="cover-color-1">You are the Pro,</span> <span class="cover-color-2">Junior</span> <span class="cover-color-3">codes</span>

Welcome to **Junior**, your AI-first IDE.

EOF

# Step 2: Update docsifyConfig.js to enable the cover page feature.
cat > ./docs/docsifyConfig.js << 'EOF'
window.$docsify = {
  name: 'Junior',
  repo: 'https://github.com/tisztamo/Junior',
  loadSidebar: true,
  autoHeader: true,
  logo: "assets/logo.svg",
  nameLink: 'https://github.com/tisztamo/Junior',
  coverpage: true
}
EOF

# Step 3: Update styles.css to use logo colors extensively for the cover page
cat > ./docs/assets/styles.css << 'EOF'
.app-name-link img {
  max-width: 70px;
}

iframe {
  margin: 16px;
}

/* Adding logo colors to cover page */
.cover-color-1 {
  color: rgb(59, 130, 246);
}

.cover-color-2 {
  color: rgb(253, 186, 116);
}

.cover-color-3 {
  color: rgb(185, 28, 28);
}
EOF

echo "\033[32mDone: $goal\033[0m\n"