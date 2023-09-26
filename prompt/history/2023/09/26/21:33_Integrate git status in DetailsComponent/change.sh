#!/bin/sh
set -e
goal="Integrate git status in DetailsComponent"
echo "Plan:"
echo "1. Modify GitStatusDisplay.jsx to incorporate DetailsComponent."
echo "2. Implement dynamic header logic based on git status."
echo "3. Clean up any redundant comments and functions."

# Step 1 & 2: Modify GitStatusDisplay.jsx to incorporate DetailsComponent and dynamic header.
cat > ./src/frontend/components/GitStatusDisplay.jsx << 'EOF'
import { onCleanup, onMount, createEffect, createSignal } from 'solid-js';
import GitStatusRow from './GitStatusRow';
import FileViewer from './files/FileViewer';
import { gitStatus } from '../model/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';
import DetailsComponent from './DetailsComponent';

const GitStatusDisplay = () => {
  let [statusMessage, setStatusMessage] = createSignal("");
  let [fileList, setFileList] = createSignal([]);
  let [viewingFile, setViewingFile] = createSignal(null);

  const generateHeader = () => {
    const filesChanged = fileList().length;
    return filesChanged === 0 ? "Directory clean" : `${filesChanged} Files changed`;
  };

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

  const handleFileClick = (path) => {
    setViewingFile(path);
  };

  const closeFileViewer = () => {
    setViewingFile(null);
  };

  return (
    <DetailsComponent
      defaultState="closed"
      localStorageKey="Junior.gitStatus.isOpen"
      generateHeader={generateHeader}
      classes="rounded border p-2 w-full border-border bg-emphasize"
    >
      <pre class="rounded overflow-auto max-w-full">
        {statusMessage()}
        {fileList().map(entry => <GitStatusRow key={entry.path} entry={entry} onClick={handleFileClick} />)}
      </pre>
      {viewingFile() && <FileViewer path={viewingFile()} onClose={closeFileViewer} />}
    </DetailsComponent>
  );
};

export default GitStatusDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"