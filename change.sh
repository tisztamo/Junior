#!/bin/sh
set -e
goal="Convert SVG to PNG, make favicon transparent"
echo "Plan:"
echo "1. Create a JavaScript file to convert SVG to PNG using the sharp library"
echo "2. Run the JavaScript file"
echo "3. Convert the PNG to ICO with a transparent background using png-to-ico"
echo "4. Replace the existing favicon.ico with the new transparent one"

# Step 1: Create a JavaScript file to convert SVG to PNG
cat > convert-svg-to-png.cjs << 'EOF'
const sharp = require('sharp');
const fs = require('fs');

const inputSVGPath = 'docs/assets/logo.svg';
const outputPNGPath = 'docs/assets/logo.png';

sharp(inputSVGPath)
  .png()
  .toBuffer((err, buffer) => {
    if (err) throw err;
    fs.writeFileSync(outputPNGPath, buffer);
  });
EOF

# Install sharp library locally
npm install sharp

# Step 2: Run the JavaScript file
node convert-svg-to-png.cjs

# Step 3: Convert the PNG to ICO with a transparent background
npm install -g png-to-ico
png-to-ico docs/assets/logo.png > docs/assets/favicon.ico

# Step 4: Replace the existing favicon.ico with the new transparent one
# The following line is not required as it's overwriting the same file
# cp docs/assets/favicon.ico docs/assets/favicon.ico

echo "\033[32mDone: $goal\033[0m\n"
