import { loadPromptFile } from './loadPromptFile.js';

const loadTaskTemplate = async (taskTemplatePath, templateVars) => {
  return await loadPromptFile(taskTemplatePath, templateVars);
};

export { loadTaskTemplate };
