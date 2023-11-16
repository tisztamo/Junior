import { attention, setAttention } from './attentionModel';

const normalizePath = (path) => path.startsWith('./') ? path.substring(2) : path;

const useAttention = () => {
  const addAttention = (path) => {
    path = normalizePath(path);
    setAttention((prev) => [...prev, path]);
  };

  return { addAttention, attention, setAttention };
};

export { useAttention };
