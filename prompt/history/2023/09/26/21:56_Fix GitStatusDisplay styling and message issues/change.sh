#!/bin/sh
set -e
goal="Fix GitStatusDisplay styling and message issues"
echo "Plan:"
echo "1. Replace non-existent 'color-gray' with a valid Tailwind class."
echo "2. Remove the unnecessary quotes around the 'clear' status message."

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
    if (filesChanged === 0) {
      return (
        <span className="text-gray-400">
          nothing to commit, working tree clean
        </span>
      );
    } else {
      return (
        <span style={{ color: 'var(--color-orange)' }}>
          {`${filesChanged} Files changed`}
        </span>
      );
    }
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