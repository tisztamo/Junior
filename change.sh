#!/bin/sh
set -e
goal="Rename and refactor SVG to PNG converter"
echo "Plan:"
echo "1. Rename convert-svg-to-png.cjs to updateLogo.js"
echo "2. Refactor updateLogo.js to use ES6 imports and async/await, and invoke the conversion function"
echo "3. Update package.json script for update-logo to use the new script name"

# Step 1: Rename convert-svg-to-png.cjs to updateLogo.js
mv scripts/convert-svg-to-png.cjs scripts/updateLogo.js

# Step 2: Refactor updateLogo.js
cat << 'EOF' > scripts/updateLogo.js
import sharp from 'sharp';
import { writeFileSync } from 'fs';

const inputSVGPath = 'docs/assets/logo.svg';
const outputPNGPath = 'docs/assets/logo.png';

const updateLogo = async () => {
  try {
    const buffer = await sharp(inputSVGPath).png().toBuffer();
    writeFileSync(outputPNGPath, buffer);
  } catch (err) {
    throw err;
  }
};

updateLogo();
EOF

# Step 3: Update package.json script
tmpfile=$(mktemp)
jq '.scripts["update-logo"] = "node ./scripts/updateLogo.js"' package.json > "$tmpfile" && mv "$tmpfile" package.json

echo "\033[32mDone: $goal\033[0m\n"
