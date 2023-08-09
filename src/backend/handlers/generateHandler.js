import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  const { notes, systemPrompt } = req.body;
  const { prompt } = await processPrompt(notes, systemPrompt);
  res.json({ prompt: prompt });
};
