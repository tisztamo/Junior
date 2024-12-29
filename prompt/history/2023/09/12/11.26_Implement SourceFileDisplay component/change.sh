#!/bin/sh
set -e
goal="Implement SourceFileDisplay component"
echo "Plan:"
echo "1. Create the required directories."
echo "2. Create SourceFileDisplay.jsx component in the components/files directory to display the content of a file from a given path."
echo "3. Update PromptCreation.jsx to include the SourceFileDisplay component with an example path (package.json)."
echo "4. Create a new service named 'fileReadService' in the service/files directory to handle GET requests from /files/read/[path]."

# Step 1: Create required directories
mkdir -p ./src/frontend/components/files
mkdir -p ./src/frontend/service/files

# Step 2: Create SourceFileDisplay.jsx in components/files
cat > ./src/frontend/components/files/SourceFileDisplay.jsx << 'EOF'
import { createSignal, onMount } from 'solid-js';
import fileReadService from '../../service/files/fileReadService';

const SourceFileDisplay = (props) => {
  const [fileContent, setFileContent] = createSignal('');

  const fetchData = async () => {
    const data = await fileReadService(props.path);
    setFileContent(data);
  };

  onMount(fetchData);

  return (
    <div class="rounded border p-4">
      <code>{fileContent()}</code>
    </div>
  );
};

export default SourceFileDisplay;
EOF

# Step 3: Update PromptCreation.jsx
cat > ./src/frontend/components/PromptCreation.jsx << 'EOF'
import TasksList from './TasksList';
import AttentionFileList from './AttentionFileList';
import PromptDescriptor from './PromptDescriptor';
import GenerateButton from './GenerateButton';
import PromptDisplay from './PromptDisplay';
import RequirementsEditor from './RequirementsEditor';
import SourceFileDisplay from './files/SourceFileDisplay';

const PromptCreation = () => {
  return (
    <>
      <TasksList />
      <RequirementsEditor />
      <AttentionFileList />
      <PromptDescriptor />
      <GenerateButton />
      <PromptDisplay />
      <SourceFileDisplay path="package.json" />
    </>
  );
};

export default PromptCreation;
EOF

# Step 4: Create fileReadService.js in service/files
cat > ./src/frontend/service/files/fileReadService.js << 'EOF'
import { getBaseUrl } from '../../getBaseUrl';

async function fileReadService(path) { 
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/files/read/${path}`);
  const text = await response.text();
  return text;
};

export default fileReadService;
EOF

echo "\033[32mDone: $goal\033[0m\n"