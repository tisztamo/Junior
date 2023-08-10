#!/bin/sh
set -e
goal="Update favicons when logo is updated"
echo "Plan:"
echo "1. Modify the existing updateLogo.js file to include the logic to update favicons"
echo "2. Convert the logo to appropriate favicon sizes using sharp package"
echo "3. Replace favicon in both the 'docs/assets/' and 'src/frontend/assets/' directories"

cat << 'EOF' > scripts/updateLogo.js
import sharp from 'sharp';
import { writeFileSync } from 'fs';

const inputSVGPath = 'docs/assets/logo.svg';
const outputPNGPath = 'docs/assets/logo.png';
const faviconDocsPath = 'docs/assets/favicon.ico';
const faviconFrontendPath = 'src/frontend/assets/favicon.ico';

const updateLogo = async () => {
  try {
    const buffer = await sharp(inputSVGPath).png().toBuffer();
    writeFileSync(outputPNGPath, buffer);

    // Convert logo to favicon sizes
    const faviconBuffer = await sharp(inputSVGPath).resize(16, 16).ico().toBuffer();
    
    // Update favicon in both the docs and frontend directories
    writeFileSync(faviconDocsPath, faviconBuffer);
    writeFileSync(faviconFrontendPath, faviconBuffer);
  } catch (err) {
    throw err;
  }
};

updateLogo();
EOF

echo "\033[32mDone: $goal\033[0m\n"
