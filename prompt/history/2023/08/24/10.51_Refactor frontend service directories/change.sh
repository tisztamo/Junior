#!/bin/sh
set -e
goal="Refactor frontend service directories"
echo "Plan:"
echo "1. Create service/config directory"
echo "2. Move cliArgsService.js to service/config/cliArgs.js"
echo "3. Extract isBetaEnabled to its own service file in service/config"
echo "4. Update imports in moved files"
echo "5. Update imports in RequirementsEditor.jsx to match new paths"

# Step 1: Create service/config directory
mkdir -p src/frontend/service/config

# Step 2: Move cliArgsService.js to service/config/cliArgs.js and refactor
cat << 'EOF' > src/frontend/service/config/cliArgs.js
import { getBaseUrl } from '../../getBaseUrl';

const cliArgs = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/config`, {
    method: 'GET',
    headers: { 'Content-Type': 'application/json' },
  });

  const data = await response.json();

  return data.cliargs || [];
};

export default cliArgs;
EOF

# Step 3: Extract isBetaEnabled to its own service file in service/config
cat << 'EOF' > src/frontend/service/config/isBetaEnabled.js
import cliArgs from './cliArgs';

const isBetaEnabled = async () => {
  const args = await cliArgs();
  return args.includes('--beta');
}

export default isBetaEnabled;
EOF

# Step 4: Update imports in moved files
# The only change needed was in cliArgs.js for getBaseUrl.

# Step 5: Update imports in RequirementsEditor.jsx to match new paths
cat << 'EOF' > src/frontend/components/RequirementsEditor.jsx
import { createEffect } from 'solid-js';
import postDescriptor from '../service/postDescriptor';
import { promptDescriptor, setPromptDescriptor } from '../model/promptDescriptor'; 
import { requirements, setRequirements } from '../model/requirements';
import { getYamlEntry } from '../service/getYamlEntry';
import isBetaEnabled from '../service/config/isBetaEnabled'; 
import jsyaml from 'js-yaml'; 
import AutoGrowingTextarea from './AutoGrowingTextarea';

const RequirementsEditor = () => {
  const handleRequirementsChange = async (e) => {
    await postDescriptor({ requirements: e.target.value });
  };

  const handleInput = (e) => {
    const descriptor = promptDescriptor();
    const parsed = jsyaml.load(descriptor);
    parsed.requirements = e.target.value; 
    const updatedDescriptor = jsyaml.dump(parsed);
    setPromptDescriptor(updatedDescriptor);
  };

  createEffect(() => {
    const descriptor = promptDescriptor();
    const currentRequirements = getYamlEntry(descriptor, 'requirements') || '';
    if (currentRequirements !== requirements()) {
      setRequirements(currentRequirements);
    }
  });

  const isBeta = isBetaEnabled();

  return (
    <div class="w-full flex justify-start bg-emphasize text-emphasize p-1 rounded border border-border mt-2">
      <AutoGrowingTextarea
        class="w-full bg-emphasize text-emphasize text-lg"
        placeholder={isBeta ? "Enter your requirements..." : "This is disabled for now. Call with 'npx junior-web -- --beta' to enable."}
        value={requirements()}
        onInput={e => handleInput(e)}
        onChange={e => handleRequirementsChange(e)}
        disabled={!isBeta}
      />
    </div>
  );
};

export default RequirementsEditor;
EOF

echo "\033[32mDone: $goal\033[0m\n"