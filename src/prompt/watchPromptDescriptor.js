import fs from 'fs';
import { loadPromptDescriptor } from './loadPromptDescriptor.js';
import { descriptorFileName } from './promptDescriptorConfig.js';

const watchPromptDescriptor = (rawPrinter) => {
  fs.watchFile(descriptorFileName, async (curr, prev) => {
    if (curr.mtime !== prev.mtime) {
      await loadPromptDescriptor(rawPrinter);
    }
  });
};

export default watchPromptDescriptor;
