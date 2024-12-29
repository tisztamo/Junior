#!/bin/sh
set -e
goal="Refactor GitStatusDisplay, eliminate refs and innerText"
echo "Plan:"
echo "1. Create GitStatusRow.jsx"
echo "2. Refactor GitStatusDisplay.jsx to use GitStatusRow component, signals, and remove innerText usage"

# 1. Create GitStatusRow.jsx
cat > ./src/frontend/components/GitStatusRow.jsx << 'EOF'
import getBackgroundColorForFile from './getBackgroundColorForFile';

const GitStatusRow = (props) => {
  const { index, path, working_dir } = props.entry;
  const bgColor = getBackgroundColorForFile(index, path);
  return (
    <div class={`grid grid-cols-3 ${bgColor ? 'bg-' + bgColor : ''}`}>
      <span class="col-span-1 w-50px">{index}</span>
      <span class="col-span-1 w-60%">{path}</span>
      <span class="col-span-1">{working_dir}</span>
    </div>
  );
};

export default GitStatusRow;
EOF

# 2. Refactor GitStatusDisplay.jsx
cat > ./src/frontend/components/GitStatusDisplay.jsx << 'EOF'
import { onMount, createEffect, createSignal } from 'solid-js';
import GitStatusRow from './GitStatusRow';
import { gitStatus } from '../model/gitStatus';
import { fetchGitStatus } from '../service/fetchGitStatus';

const GitStatusDisplay = () => {
  let [statusMessage, setStatusMessage] = createSignal("");
  let [fileList, setFileList] = createSignal([]);

  onMount(async () => {
    try {
      await fetchGitStatus();
      const gitStatusValue = gitStatus();
      if (gitStatusValue.error) {
        setStatusMessage(`${gitStatusValue.message}\n${gitStatusValue.error.stderr}`);
      } else if (gitStatusValue.data && gitStatusValue.data.files) {
        setFileList(gitStatusValue.data.files);
      }
    } catch (error) {
      setStatusMessage("Error fetching git status.");
    }
  });

  return (
    <pre class="rounded overflow-auto max-w-full">
      {statusMessage()}
      {fileList().map(entry => <GitStatusRow key={entry.path} entry={entry} />)}
    </pre>
  );
};

export default GitStatusDisplay;
EOF

echo "\033[32mDone: $goal\033[0m\n"