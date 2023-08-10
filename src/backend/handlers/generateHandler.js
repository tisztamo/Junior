import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  try {
    const { notes, systemPrompt } = req.body;
    const { prompt } = await processPrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    res.json({ error: error.message });
  }
};
