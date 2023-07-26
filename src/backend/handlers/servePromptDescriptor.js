import { loadPromptDescriptor } from '../../prompt/loadPromptDescriptor.js';

export const servePromptDescriptor = async (req, res) => {
  const file = await loadPromptDescriptor();
  res.send(file);
};
