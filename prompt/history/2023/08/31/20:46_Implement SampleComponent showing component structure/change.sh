#!/bin/sh
set -e
goal="Implement SampleComponent showing component structure"
echo "Plan:"
echo "1. Create SampleComponent.jsx"
echo "2. Show how to use model, local state, and services"
echo "3. Ensure proper component structuring"

# Step 1: Create SampleComponent.jsx
cat > ./src/frontend/components/SampleComponent.jsx << EOF
import { createSignal, onCleanup } from 'solid-js';
import { sampleModel } from '../model/sampleModel';
import { sampleService } from '../service/sampleService';

const SampleComponent = () => {
  const modelValue = sampleModel();
  const [localState, setLocalState] = createSignal('');

  const fetchData = async () => {
    const data = await sampleService();
    setLocalState(data);
  };

  onCleanup(() => {});

  return (
    <div class="rounded border p-4">
      <div>{modelValue}</div>
      <div>{localState()}</div>
      <button class="bg-blue-500 text-white px-4 py-2 rounded" onClick={fetchData}>Fetch Data</button>
    </div>
  );
};

export default SampleComponent;
EOF

echo "\033[32mDone: $goal\033[0m\n"