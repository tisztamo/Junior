import fs from 'fs';
import util from 'util';

const writeFile = util.promisify(fs.writeFile);
import { descriptorFileName } from "./promptDescriptorConfig.js";

const savePromptDescriptor = async (data) => {
  await writeFile(descriptorFileName, data, 'utf8');
};

export { savePromptDescriptor };
