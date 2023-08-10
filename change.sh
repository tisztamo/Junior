#!/bin/sh
set -e
goal="Fix sharp resize, ico conversion error, and call updateLogo"
echo "Plan:"
echo "1. Replace the incorrect ico conversion code with proper format conversion for favicon."
echo "2. Export the function 'updateLogo' since the project's requirement is to export a single function from each js file."
echo "3. Call the 'updateLogo' function."

cat > scripts/updateLogo.js << 'EOF'
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
    const faviconBuffer = await sharp(inputSVGPath).resize({ width: 16, height: 16 }).toFormat('png').toBuffer();
    
    // Update favicon in both the docs and frontend directories
    writeFileSync(faviconDocsPath, faviconBuffer);
    writeFileSync(faviconFrontendPath, faviconBuffer);
  } catch (err) {
    throw err;
  }
};

updateLogo();

export default updateLogo;
EOF

echo "\033[32mDone: $goal\033[0m\n"
