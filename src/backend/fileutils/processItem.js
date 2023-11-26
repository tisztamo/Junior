import fs from 'fs';
import path from 'path';

async function processItem(readFileList, dir, relativePath, item, nameIgnore, pathIgnore) {
  if (nameIgnore.includes(item)) return;
  const fullPath = path.join(dir, item);
  if (pathIgnore.includes(fullPath.replace(/^.\//, ''))) return;
  const stats = await fs.promises.stat(fullPath);
  if (stats.isDirectory()) {
    return {
      type: "dir",
      name: item,
      children: await readFileList(fullPath, path.join(relativePath, item), nameIgnore, pathIgnore)
    };
  } else {
    let filePath = path.join(relativePath, item);
    if (filePath.startsWith('./')) {
      filePath = filePath.substring(2);
    }
    return {
      type: "file",
      name: item,
      path: filePath
    };
  }
}

export default processItem;
