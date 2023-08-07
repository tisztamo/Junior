#!/bin/sh
set -e
goal="Improving documentation config"
echo "Plan:"
echo "1. Update docs/docsifyConfig.js with new configs."

cat > docs/docsifyConfig.js << 'EOF'
window.$docsify = {
  name: 'Junior',
  repo: 'https://github.com/tisztamo/Junior',
  loadSidebar: true,
  autoHeader: true,
  logo: "assets/logo.svg",
  nameLink: 'https://github.com/tisztamo/Junior'
}
EOF

echo "\033[32mDone: $goal\033[0m\n"
