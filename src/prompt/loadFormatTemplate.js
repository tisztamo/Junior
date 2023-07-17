import { loadPromptFile } from './loadPromptFile.js';

const loadFormatTemplate = async (formatTemplatePath, templateVars) => {
  return await loadPromptFile(formatTemplatePath, templateVars);
};

export { loadFormatTemplate };
