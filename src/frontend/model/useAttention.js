import { attention, setAttention } from './attentionModel';

const useAttention = () => {
  const addAttention = (path) => {
    setAttention((prev) => [...prev, path]);
  };

  return { addAttention };
};

export { useAttention };
