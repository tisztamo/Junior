import YAML from 'yaml';

export const getYamlEntry = (yamlString, entry) => {
  const doc = YAML.parse(yamlString);
  return doc ? doc[entry] : null;
};
