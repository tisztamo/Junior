import fs from 'fs';
import util from 'util';

const readFile = util.promisify(fs.readFile);
const descriptorFileName = "prompt.yaml";

const loadPromptDescriptor = async (rawPrinter) => {
  const descriptorContent = await readFile(descriptorFileName, 'utf8');
  if (rawPrinter) {
    rawPrinter(descriptorFileName + ':\n' + descriptorContent);
  }
  return descriptorContent;
};

export { loadPromptDescriptor };
