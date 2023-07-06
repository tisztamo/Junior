import { readFile, writeFile } from 'fs/promises';
import path from 'path';
import yaml from 'js-yaml';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const updateTaskHandler = async (req, res) => {
  const task = req.body.task;
  const filePath = path.resolve(__dirname, '../../prompt.yaml');

  try {
    const fileContent = await readFile(filePath, 'utf-8');
    const document = yaml.load(fileContent);

    // assuming 'task' is a field in the yaml document
    document.task = task;

    const newYamlStr = yaml.dump(document);
    await writeFile(filePath, newYamlStr, 'utf-8');
    
    res.status(200).json({ message: "Task updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};
