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
