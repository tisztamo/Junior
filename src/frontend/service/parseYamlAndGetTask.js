import YAML from 'yaml';

export const parseYamlAndGetTask = (yamlString) => {
  const doc = YAML.parse(yamlString);
  // Remove 'prompt/task/' prefix
  const task = doc.task.replace('prompt/task/', '');
  return task;
};
