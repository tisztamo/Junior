#!/bin/sh
set -e
goal="Add auto2top to docsify config"
echo "Plan:"
echo "1. Modify docs/docsifyConfig.js to include auto2top property."

cat > docs/docsifyConfig.js << 'EOF'
window.$docsify = {
  name: 'Junior',
  repo: 'https://github.com/tisztamo/Junior',
  loadSidebar: true,
  autoHeader: true,
  logo: "assets/logo.svg",
  nameLink: 'https://github.com/tisztamo/Junior',
  coverpage: true,
  auto2top: true
}
EOF

echo "\033[32mDone: $goal\033[0m\n"