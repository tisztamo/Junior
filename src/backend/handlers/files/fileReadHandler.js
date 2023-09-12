import fs from 'fs';
import { promisify } from 'util';

const readFileAsync = promisify(fs.readFile);

export async function fileReadHandler(req, res) {
  const { filepath } = req.params;

  if (!filepath) {
    return res.status(400).send({ error: 'File path is required' });
  }

  try {
    const fileContent = await readFileAsync(filepath, 'utf8');
    res.send(fileContent);
  } catch (error) {
    res.status(500).send({ error: 'Unable to read file' });
  }
}
