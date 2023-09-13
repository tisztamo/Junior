import fs from 'fs';
import { promisify } from 'util';
import { sanitizeAndResolvePath } from '../../fileutils/sanitizeAndResolvePath.js';

const readFileAsync = promisify(fs.readFile);

export async function fileReadHandler(req, res) {
  const { filepath } = req.params;

  if (!filepath) {
    return res.status(400).send({ error: 'File path is required' });
  }

  try {
    const resolvedPath = sanitizeAndResolvePath(filepath);
    if (!fs.existsSync(resolvedPath)) {  // Check if file exists
      return res.status(404).send({ error: 'File not found' });
    }
    const fileContent = await readFileAsync(resolvedPath, 'utf8');
    res.send(fileContent);
  } catch (error) {
    res.status(500).send({ error: 'Unable to read file' });
  }
}
