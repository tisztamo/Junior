#!/bin/sh
set -e
goal="Create and replace logo file"
echo "Plan:"
echo "1. Create the SVG logo file with the given specifications."
echo "2. Convert the SVG file to PNG using 'convert'."
echo "3. Overwrite the old PNG logo file."

# Step 1: Create the SVG logo file with the given specifications.
cat > ./docs/assets/logo.svg << 'EOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
    <rect x="0" y="0" rx="10" ry="10" width="100" height="30" style="fill:blue;" />
    <rect x="0" y="33" rx="10" ry="10" width="100" height="30" style="fill:orange;" />
    <rect x="0" y="66" rx="10" ry="10" width="48" height="34" style="fill:red;" />
    <rect x="52" y="66" rx="10" ry="10" width="48" height="34" style="fill:green;" />
</svg>
EOF

# Step 2: Convert the SVG file to PNG using 'convert'.
convert ./docs/assets/logo.svg ./docs/assets/logo.png

# Step 3: Overwrite the old PNG logo file.
mv -f ./docs/assets/logo.png ./docs/assets/logo.png

echo "\033[32mDone: $goal\033[0m\n"
