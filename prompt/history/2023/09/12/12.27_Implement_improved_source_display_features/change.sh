#!/bin/sh
set -e
goal="Implement improved source display features"
echo "Plan:"
echo "1. Update the index.html file to change the Prism.js theme to 'prism-holi-theme'."
echo "2. Modify SourceFileDisplay.jsx to make the source display take full width and allow horizontal scrolling."

# Step 1: Update the index.html file to change the Prism.js theme
cat > ./src/frontend/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link rel="icon" href="/assets/favicon.ico" type="image/x-icon">
  <link href="https://unpkg.com/prism-themes@1.9.0/themes/prism-holi-theme.min.css" rel="stylesheet" />
  <title>Junior</title>
</head>
<body>
  <div id="app" class="bg-emphasize"></div>
  <script type="module" src="/index.jsx"></script>
  <script src="https://unpkg.com/prismjs@v1.x/components/prism-core.min.js"></script>
  <script src="https://unpkg.com/prismjs@v1.x/plugins/autoloader/prism-autoloader.min.js"></script>
</body>
</html>
EOF

# Step 2: Modify SourceFileDisplay.jsx to make the source display take full width and allow horizontal scrolling
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
  };

  onMount(fetchData);

  const language = getLanguageFromPath(props.path);

  return (
    <div class="rounded border p-4 w-full overflow-x-auto">
      <pre><code class={`language-${language}`}>{fileContent()}</code></pre>
    </div>
  );
};

export default SourceFileDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"