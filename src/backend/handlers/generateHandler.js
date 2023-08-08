import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
};
