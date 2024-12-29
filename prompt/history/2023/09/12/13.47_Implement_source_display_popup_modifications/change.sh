#!/bin/sh
set -e
goal="Implement source display popup modifications"
echo "Plan:"
echo "1. Modify the FullScreenPopup to have width 'w-full mx-2' and remove the 'close' label from the button."
echo "2. In the SourceFileDisplay component, ensure that Prism highlights the loaded content after mounting."

# Modify the FullScreenPopup.jsx
cat > ./src/frontend/components/MultiSelect/FullScreenPopup.jsx << 'EOF'
import SourceFileDisplay from '../files/SourceFileDisplay';

const FullScreenPopup = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50" onClick={props.onClose}>
      <div class="absolute inset-0 bg-black opacity-50"></div>
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-white w-full mx-2 h-3/4 rounded-lg overflow-y-auto">
          <div class="absolute top-4 right-4" onClick={props.onClose}></div>
          <SourceFileDisplay path={props.path} />
        </div>
      </div>
    </div>
  );
};

export default FullScreenPopup;
EOF

# Modify the SourceFileDisplay.jsx
cat > ./src/frontend/components/files/SourceFileDisplay.jsx << 'EOF'
import { createSignal, onMount } from 'solid-js';
import fileReadService from '../../service/files/fileReadService';

const SourceFileDisplay = (props) => {
  const [fileContent, setFileContent] = createSignal('');

  const getLanguageFromPath = (path) => {
    const extension = path.split('.').pop().toLowerCase();
    return extension;
  };

  const fetchData = async () => {
    const data = await fileReadService(props.path);
    setFileContent(data);

    // Ensure Prism highlights the loaded content
    if (window.Prism) {
      window.Prism.highlightAll();
    }
  };

  onMount(fetchData);

  const language = getLanguageFromPath(props.path);

  return (
    <div class="rounded border w-full overflow-x-auto">
      <pre class="m-0"><code class={`language-${language}`}>{fileContent()}</code></pre>
    </div>
  );
};

export default SourceFileDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"