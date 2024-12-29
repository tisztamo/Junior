#!/bin/sh
set -e
goal="Integrate handleAttentionChange in addAttention, ensure setAttention availability"
echo "Plan:"
echo "1. Modify attentionModel.js to correctly export setAttention"
echo "2. Update useAttention.js to import and use handleAttentionChange correctly"
echo "3. Ensure all necessary exports are maintained"

# Step 1: Modify attentionModel.js to correctly export setAttention
cat > ./src/frontend/model/attentionModel.js << 'EOF'
import { createSignal } from 'solid-js';

const [attention, setAttention] = createSignal([]);

export { attention, setAttention };
EOF

# Step 2: Update useAttention.js to import and use handleAttentionChange correctly
cat > ./src/frontend/model/useAttention.js << 'EOF'
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
EOF

echo "\033[32mDone: $goal\033[0m\n"