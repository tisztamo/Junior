import fs from 'fs';
import { descriptorFileName } from '../prompt/promptDescriptorConfig.js';
import { servePromptDescriptor } from './servePromptDescriptor.js';

const watchPromptDescriptor = (ws) => {
  fs.watchFile(descriptorFileName, async (curr, prev) => {
    if (curr.mtime !== prev.mtime) {
      const file = await servePromptDescriptor();
      ws.send(file);
    }
  });
};

export default watchPromptDescriptor;
