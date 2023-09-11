import { promptDescriptor } from '../model/promptDescriptor';
import { getYamlEntry } from './getYamlEntry';

export const getAttentionFromDescriptor = () => {
  const descriptor = promptDescriptor();
  if (descriptor !== '') {
    return getYamlEntry(descriptor, 'attention');
  }
  return [];
};
