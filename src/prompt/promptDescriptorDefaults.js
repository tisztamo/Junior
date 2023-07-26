import { loadPromptFile } from './loadPromptFile.js';

const loadDefaults = async () => {
  let promptDescriptorDefaults = {};
  const files = ['format', 'os', 'installedTools'];
  for (let file of files) {
    promptDescriptorDefaults[file] = await loadPromptFile(`prompt/${file}.md`);
  }
  return promptDescriptorDefaults;
}

export default loadDefaults;
