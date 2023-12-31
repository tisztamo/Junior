import { handleAttentionChange } from '../service/handleAttentionChange';
import { attention, setAttention as originalSetAttention } from './attentionModel';

const normalizePath = (path) => path.startsWith('./') ? path.substring(2) : path;

const setAttention = async (paths) => {
  const normalizedPaths = paths.map(normalizePath);
  await originalSetAttention(normalizedPaths);
};

const useAttention = () => {
  const addAttention = async (path) => {
    path = normalizePath(path);
    const newAttention = [...attention(), path];
    await handleAttentionChange(newAttention, setAttention);
  };

  const removeAttention = async (path) => {
    path = normalizePath(path);
    const newAttention = attention().filter(item => item !== path);
    await handleAttentionChange(newAttention, setAttention);
  };

  const isInAttention = (path) => {
    path = normalizePath(path);
    return attention().includes(path);
  };

  return { addAttention, removeAttention, isInAttention, attention, setAttention };
};

export { useAttention };
