import processPrompt from '../prompt/promptProcessing.js';
import { servePromptDescriptor } from './servePromptDescriptor.js';

export const generateHandler = async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
};

export const descriptorHandler = servePromptDescriptor;
