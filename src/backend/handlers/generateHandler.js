import generatePrompt from '../../prompt/generatePrompt.js';
import isRepoClean from '../../git/isRepoClean.js';
import { isDebug } from '../../config/isDebug.js';

export const generateHandler = async (req, res) => {
  try {
    const debugEnabled = isDebug();

    if (!debugEnabled && !await isRepoClean()) {
      throw new Error("Directory is not clean. Please commit or stash changes and try again. Use --debug to bypass this check.");
    } else if (debugEnabled && !await isRepoClean()) {
      console.warn('\x1b[33m%s\x1b[0m', 'Warning: Debug mode enabled and the directory is not clean.');
    }

    const { notes, systemPrompt } = req.body;
    const { prompt } = await generatePrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    res.status(500).json({ error: error.message });
  }
};
