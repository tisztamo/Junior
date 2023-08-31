import fs from 'fs';
import path from 'path';

async function readFileList(dir, relativePath = "") {
  const items = await fs.promises.readdir(dir);
  const itemDetails = await Promise.all(
    items.map(async item => {
      const fullPath = path.join(dir, item);
      const stats = await fs.promises.stat(fullPath);
      if (stats.isDirectory()) {
        if (item !== "node_modules" && item !== "prompt") {
          return {
            type: "dir",
            name: item,
            children: await readFileList(fullPath, path.join(relativePath, item))
          };
        }
      } else {
        return {
          type: "file",
          name: item,
          path: path.join(relativePath, item)
        };
      }
    })
  );

  return itemDetails.filter(Boolean);
}

export default readFileList;
