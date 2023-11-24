#!/bin/sh
set -e
goal="Implement PromptsToTry Component in SolidJS"
echo "Plan:"
echo "1. Create a new directory for the component."
echo "2. Implement the PromptsToTry component."
echo "3. Create the promptsToTryModel."
echo "4. Modify PromptCreation.jsx to include the new component."
echo "5. Test to ensure everything works as expected."

mkdir -p src/frontend/components/promptCreation

cat > src/frontend/components/promptCreation/PromptsToTry.jsx << 'EOF'
import { For } from 'solid-js';
import { promptsToTry } from '../../model/promptsToTryModel';

const PromptsToTry = () => {
  return (
    <div class="flex space-x-4 overflow-x-auto py-2">
      <div class="font-bold">Prompts to try:</div>
      <For each={promptsToTry()}>{(prompt) => 
        <div class="bg-gray-200 rounded px-4 py-2">{prompt.name}</div>
      }</For>
    </div>
  );
};

export default PromptsToTry;
EOF

cat > src/frontend/model/promptsToTryModel.js << 'EOF'
import { createSignal } from 'solid-js';

const [promptsToTry, setPromptsToTry] = createSignal([
  { name: 'Sample 1', content: 'Content 1' },
  { name: 'Sample 2', content: 'Content 2' },
  { name: 'Sample 3', content: 'Content 3' },
]);

export { promptsToTry, setPromptsToTry };
EOF

sed -i '' '/import RequirementsEditor/a\
import PromptsToTry from "./promptCreation/PromptsToTry";\
' src/frontend/components/PromptCreation.jsx

sed -i '' '/<RequirementsEditor \/>/i\
<PromptsToTry />\
' src/frontend/components/PromptCreation.jsx

echo "\033[32mDone: $goal\033[0m\n"