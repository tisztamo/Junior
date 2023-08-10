#!/bin/sh
set -e
goal="Update SVG Colors"
echo "Plan:"
echo "1. Update the colors in docs/assets/logo.svg according to requirements."
echo "2. Call the update script."

cat > docs/assets/logo.svg << 'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
    <rect x="0" y="0" rx="10" ry="10" width="100" height="30" style="fill:rgb(59 130 246);" />
    <rect x="0" y="33" rx="10" ry="10" width="100" height="30" style="fill:rgb(253, 186, 116);" />
    <rect x="0" y="66" rx="10" ry="10" width="48" height="34" style="fill:rgb(185, 28, 28);" />
    <rect x="52" y="66" rx="10" ry="10" width="48" height="34" style="fill:rgb(21, 128, 61);" />
</svg>
EOF

npm run update-logo

echo "\033[32mDone: $goal\033[0m\n"
