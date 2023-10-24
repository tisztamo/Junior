#!/bin/sh
set -e
goal="Optimize Prism syntax highlighting performance"
echo "Plan:"
echo "1. Modify SourceFileDisplay.jsx to optimize Prism highlighting as per the suggestion provided."
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

    // Optimized Prism highlighting
    if (window.Prism) {
      const codeElement = document.querySelector('.source-display-code');
      const pre = codeElement.parentElement;
      
      const newCode = document.createElement('CODE');
      newCode.className = codeElement.className;
      newCode.textContent = data;

      window.Prism.highlightElement(newCode, true, function () {
        pre.replaceChild(newCode, codeElement);
      });
    }
  };

  onMount(fetchData);

  const language = getLanguageFromPath(props.path);

  return (
    <div class="rounded border w-full overflow-x-auto">
      <pre class="m-0"><code class={`language-${language} source-display-code`}>{fileContent()}</code></pre>
    </div>
  );
};

export default SourceFileDisplay;
EOF
echo "\033[32mDone: $goal\033[0m\n"
