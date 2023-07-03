// Extracts template variables from the prompt descriptor.
function extractTemplateVars(promptDescriptor) {
  return Object.keys(promptDescriptor)
    .filter(key => ['task', 'format', 'attention', 'saveto'].indexOf(key) < 0)
    .reduce((obj, key) => {
      obj[key] = promptDescriptor[key];
      return obj;
    }, {});
}

export { extractTemplateVars };
