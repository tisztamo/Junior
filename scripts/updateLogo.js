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
