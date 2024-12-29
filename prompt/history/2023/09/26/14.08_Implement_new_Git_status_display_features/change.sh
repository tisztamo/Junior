#!/bin/sh
set -e
goal="Implement new Git status display features"
echo "Plan:"
echo "1. Modify the getStyleForFileStatus function to support ? for new files"
echo "2. Add max-w-full to the wrapper div of the Git status display"

# Modify getStyleForFileStatus.jsx
cat > ./src/frontend/components/getStyleForFileStatus.jsx << 'EOF'
export default function getStyleForFileStatus(working_dir, path) {
  if (working_dir === 'M') {
    return { color: 'var(--color-green)' };
  } else if ((working_dir === 'A' || working_dir === '?') && !path.includes('prompt/history')) {
    return { color: 'var(--color-orange)' };
  } else if (working_dir === 'D') {
    return { color: 'var(--color-red)' };
  }
  return {}; // Default no text color style
}
EOF

# Modify GitStatusDisplay.jsx
cat > ./src/frontend/components/GitStatusDisplay.jsx << 'EOF'
import { onCleanup, onMount, createEffect, createSignal } from 'solid-js';
import GitStatusRow from './GitStatusRow';
import FileViewer from './files/FileViewer';
import { gitStatus } from '../model/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let [statusMessage, setStatusMessage] = createSignal("");
  let [fileList, setFileList] = createSignal([]);
  let [viewingFile, setViewingFile] = createSignal(null);

  onMount(async () => {
    try {
      await fetchGitStatus();
    } catch (error) {
      setStatusMessage("Error fetching git status.");
    }
  });

  createEffect(() => {
    const gitStatusValue = gitStatus();
    if (gitStatusValue.error) {
      setStatusMessage(`${gitStatusValue.message}\n${gitStatusValue.error.stderr}`);
    } else if (gitStatusValue.data && gitStatusValue.data.files) {
      setFileList(gitStatusValue.data.files);
    }
  });

  onCleanup(() => {
    // Clean up any listeners or resources tied to this component.
  });

  const handleFileClick = (path) => {
    setViewingFile(path);
  };

  const closeFileViewer = () => {
    setViewingFile(null);
  };

  return (
    <div class="max-w-full">
      <pre class="rounded overflow-auto max-w-full">
        {statusMessage()}
        {fileList().map(entry => <GitStatusRow key={entry.path} entry={entry} onClick={handleFileClick} />)}
      </pre>
      {viewingFile() && <FileViewer path={viewingFile()} onClose={closeFileViewer} />}
    </div>
  );
};

export default GitStatusDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"