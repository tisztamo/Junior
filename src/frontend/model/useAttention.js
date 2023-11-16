import { handleAttentionChange } from '../service/handleAttentionChange';
import { attention, setAttention } from './attentionModel';

const normalizePath = (path) => path.startsWith('./') ? path.substring(2) : path;

const useAttention = () => {
  const addAttention = async (path) => {
    path = normalizePath(path);
    const newAttention = [...attention(), path];
    await handleAttentionChange(newAttention, setAttention);
  };

  return { addAttention, attention, setAttention };
};

export { useAttention };
