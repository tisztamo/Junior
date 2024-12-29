#!/bin/sh
set -e
goal="Wrap setAttention with path normalization"
echo "Plan:"
echo "1. Implement a wrapper for setAttention in useAttention.js."
echo "2. Export the new wrapper instead of the original setAttention."
echo "3. Adjust existing setAttention calls to use the wrapper."

# Modifying useAttention.js
cat > ./src/frontend/model/useAttention.js << 'EOF'
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
EOF

echo "\033[32mDone: $goal\033[0m\n"