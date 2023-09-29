import { promises as fs } from 'fs';
import { join } from 'path';

async function searchFiles(dir) {
  const dirents = await fs.readdir(dir, { withFileTypes: true });
  const files = await Promise.all(dirents.map(async (dirent) => {
    const res = join(dir, dirent.name);
    if (dirent.isDirectory()) {
      return searchFiles(res);
    } else if (dirent.isFile() && res.endsWith('.js')) {
      const content = await fs.readFile(res, 'utf8');
      return { path: res, content };
    }
    return null;
  }));

  return files.flat().filter(Boolean);
}

export { searchFiles };
