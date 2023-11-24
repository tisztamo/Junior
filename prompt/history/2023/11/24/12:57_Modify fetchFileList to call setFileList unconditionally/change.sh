#!/bin/sh
set -e
goal="Modify fetchFileList to call setFileList unconditionally"
echo "Plan:"
echo "1. Modify fetchFileList.js to call setFileList unconditionally."

cat > src/frontend/service/fetchFileList.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';
import { setFileList } from '../model/fileList';
import flattenPaths from './helpers/flattenPaths';

async function fetchFileList() {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/files/list`);
  const data = await response.json();
  let fileList = [];

  // Handle data and update file list
  if (Array.isArray(data)) {
    fileList = flattenPaths({
      type: "dir",
      name: ".",
      children: data
    }, '');
  }

  // Call setFileList unconditionally with either processed or empty data
  setFileList(fileList);
}

export default fetchFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"