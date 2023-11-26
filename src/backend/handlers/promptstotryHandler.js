import readFileList from '../fileutils/readFileList.js';
import fs from 'fs';
import { fileURLToPath } from 'url';
import path from 'path';
import getProjectRoot from '../fileutils/getProjectRoot.js';

async function readFiles(dirPath) {
  const files = await readFileList(dirPath);
  return Promise.all(files.children.map(async file => {
    const content = await fs.promises.readFile(path.join(dirPath, file.name), 'utf8');
    return { name: file.name, content };
  }));
}

export async function promptstotryHandler(req, res) {
    const PROMPTS_DIR = 'prompt/totry';
    let dirPath = path.join(process.cwd(), PROMPTS_DIR);
    let fileContents = await readFiles(dirPath);
    
    if (!fileContents.length) {
      const projectRoot = getProjectRoot();
      dirPath = path.join(projectRoot, PROMPTS_DIR);
      fileContents = await readFiles(dirPath);
    }

    res.json(fileContents);
}
