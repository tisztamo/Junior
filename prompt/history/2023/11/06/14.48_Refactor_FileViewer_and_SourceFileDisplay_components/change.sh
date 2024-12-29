#!/bin/sh
set -e
goal="Refactor FileViewer and SourceFileDisplay components"

# Short README about the working set, task, and its challenges
echo "Working Set:"
echo "./src/frontend/components/files/FileViewer.jsx"
echo "./src/frontend/components/files/SourceFileDisplay.jsx"
echo ""
echo "Task:"
echo "- In FileViewer.jsx, adjust div classes for layout fixes."
echo "- In SourceFileDisplay.jsx, add scrolling functionality to the code display div."
echo ""
echo "Challenges:"
echo "- Ensuring that the changes adhere to the SolidJS and Tailwind paradigms."
echo "- Keeping the code idiomatic and ES6-compliant as per project specifics."
echo ""

# Plan
echo "Plan:"
echo "1. Adjust classes in FileViewer.jsx for layout fixes."
echo "2. Add scrolling functionality to the code display div in SourceFileDisplay.jsx."
echo "3. Ensure the changes are compliant with ES6, SolidJS, and Tailwind."

# Make changes to FileViewer.jsx
cat > ./src/frontend/components/files/FileViewer.jsx << 'EOF'
import SourceFileDisplay from '../files/SourceFileDisplay';
import FileViewerHeader from './FileViewerHeader';

const FileViewer = (props) => {
  return (
    <div class="fixed top-0 left-0 w-full h-full z-50 bg-gray-500 bg-opacity-50">
      <div class="absolute inset-0 h-full flex justify-center items-center">
        <div class="bg-emphasize w-full mx-2 h-full rounded-lg">
          <FileViewerHeader onClose={props.onClose} path={props.path} />
          <SourceFileDisplay path={props.path} />
        </div>
      </div>
    </div>
  );
};

export default FileViewer;
EOF

# Make changes to SourceFileDisplay.jsx
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
    <div class="rounded border w-full overflow-x-auto overflow-y-auto h-full">
      <pre class={`language-${language}`} style={{ margin: 0 }}>
        <code class={`language-${language} source-display-code`}>{fileContent()}</code>
      </pre>
    </div>
  );
};

export default SourceFileDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"