import { attention, setAttention } from './attentionModel';

// Function to normalize the path
const normalizePath = (path) => path.startsWith('./') ? path.substring(2) : path;

const useAttention = () => {
  // Function to add a path to the attention list with normalization
  const addAttention = (path) => {
    path = normalizePath(path); // Normalize the path
    setAttention((prev) => [...prev, path]);
  };

  // Return both the action and the signal
  return { addAttention, attention };
};

export { useAttention };
