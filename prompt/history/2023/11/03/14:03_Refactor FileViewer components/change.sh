#!/bin/sh
set -e
goal="Refactor FileViewer components"
echo "Plan:"
echo "1. Add horizontal padding to the right of the close button in FileViewerHeader."
echo "2. Replace max-h-3/4 with max-h-full in FileViewer."
echo "3. Use inline style to set margin to 0 in SourceFileDisplay."
echo "4. Refactor to export single function or signal per file, use ES6 imports, prefer async/await, and edit .jsx files for SolidJS and Tailwind."

cat > ./src/frontend/components/files/FileViewerHeader.jsx << 'EOF'
import ListItem from '../MultiSelect/ListItem';

const FileViewerHeader = (props) => {
  return (
    <div class="flex items-center p-4 bg-emphasize">
      <button
        class="text-3xl font-bold text-emphasize mr-auto pr-2"
        onClick={props.onClose}
      >
        &times;
      </button>
      <div class="flex-grow">
        <ListItem item={props.path} />
      </div>
    </div>
  );
};

export default FileViewerHeader;
EOF

echo "FileViewerHeader updated."

cat > ./src/frontend/components/files/FileViewer.jsx << 'EOF'
import SourceFileDisplay from '../files/SourceFileDisplay';
import FileViewerHeader from './FileViewerHeader';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50 bg-gray-500 bg-opacity-50">
      <div class="absolute inset-0 flex justify-center items-center">
        <div class="bg-emphasize w-full mx-2 max-h-full rounded-lg">
          <FileViewerHeader onClose={props.onClose} path={props.path} />
          <div class="overflow-y-auto h-full">
            <SourceFileDisplay path={props.path} />
          </div>
        </div>
      </div>
    </div>
  );
};

export default FileViewer;
EOF

echo "FileViewer updated."

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

    if (window.Prism) {
      const codeElement = document.querySelector('.source-display-code');
      const pre = codeElement.parentElement;

      const newCode = document.createElement('CODE');
      newCode.className = codeElement.className;
      newCode.textContent = data;

      window.Prism.highlightElement(newCode);
      pre.replaceChild(newCode, codeElement);
    }
  };

  onMount(() => {
    fetchData();
  });

  const language = getLanguageFromPath(props.path);

  return (
    <div class="rounded border w-full overflow-x-auto">
      <pre class={`language-${language}`} style={{ margin: 0 }}>
        <code class={`language-${language} source-display-code`}>{fileContent()}</code>
      </pre>
    </div>
  );
};

export default SourceFileDisplay;
EOF

echo "SourceFileDisplay updated."

echo "\033[32mDone: $goal\033[0m\n"