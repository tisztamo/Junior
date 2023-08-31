import readFileList from '../fileutils/readFileList.js';

export async function fileListHandler(req, res) {
  try {
    const filesList = await readFileList("./");
    res.json(filesList);
  } catch (error) {
    res.status(500).json({ error: 'Failed to list files' });
  }
}
