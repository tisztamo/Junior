import processPrompt from '../../prompt/processPrompt.js';

export const generateHandler = async (req, res) => {
  try {
    const { notes, systemPrompt } = req.body;
    const { prompt } = await processPrompt(notes, systemPrompt);
    res.json({ prompt: prompt });
  } catch (error) {
    console.warn(error);
    if (error.message.startsWith("ENOENT")) {
      res.status(404).json({ error: error.message });
    } else {
      res.status(500).json({ error: error.message });
    }
  }
};
