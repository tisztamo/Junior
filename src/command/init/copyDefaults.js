import fs from 'fs';
import path from 'path';

async function copyDefaults(src, dst) {
  if (!fs.existsSync(dst)) {
    fs.mkdirSync(dst, { recursive: true });
  }

  fs.readdirSync(src).forEach(async (file) => {
    const srcPath = path.join(src, file);
    const dstPath = path.join(dst, file);
    
    if (fs.lstatSync(srcPath).isDirectory()) {
      await copyDefaults(srcPath, dstPath);
    } else {
      fs.copyFileSync(srcPath, dstPath);
    }
  });
}

export default copyDefaults;
