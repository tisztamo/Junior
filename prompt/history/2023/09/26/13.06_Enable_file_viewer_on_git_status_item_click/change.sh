#!/bin/sh
set -e
goal="Enable file viewer on git status item click"
echo "Plan:"
echo "1. Modify GitStatusRow to handle click and pass the file path to open."
echo "2. Introduce state in GitStatusDisplay to know if the file viewer is open and which file is to be displayed."
echo "3. Modify GitStatusDisplay to render FileViewer when a file is clicked."

# Modifying the GitStatusRow to accept an onClick prop and attach it to its root div.
cat > ./src/frontend/components/GitStatusRow.jsx << 'EOF'
import { createEffect } from "solid-js";
import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;
  const { onClick } = props;

  const splitPath = path.split('/');
  const fileName = splitPath.pop();
  const baseDir = splitPath.join('/');

  const bgColor = getBackgroundColorForFile(index, path);

  let pathRef;

  createEffect(() => {
    if (pathRef) {
      pathRef.scrollLeft = pathRef.scrollWidth;
    }
  });

  return (
    <div class={`flex ${bgColor ? 'bg-' + bgColor : ''}`} onClick={() => onClick(path)}>
      <span class="w-50px overflow-x-auto p-1">{index + ' ' + working_dir}</span>
      <span class="text-base bg-main rounded p-1">{fileName}</span>
      <span ref={pathRef} class="overflow-x-auto whitespace-no-wrap break-keep scrollbar-hidden ml-4 py-2 text-sm">{baseDir}</span>
    </div>
  );
};

export default GitStatusRow;
EOF

# Updating GitStatusDisplay to handle state for the FileViewer and render it when required.
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
    <div>
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