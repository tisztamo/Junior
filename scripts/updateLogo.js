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
