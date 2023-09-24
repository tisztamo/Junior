import generatePrompt from '../../prompt/generatePrompt.js';
import isRepoClean from '../../git/isRepoClean.js';

export const generateHandler = async (req, res) => {
  try {
    if (!await isRepoClean()) {
      throw new Error("Directory is not clean. Please commit or stash changes and try again.");
    }

    const { notes, systemPrompt } = req.body;
    const { prompt } = await generatePrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    res.status(500).json({ error: error.message });
  }
};
