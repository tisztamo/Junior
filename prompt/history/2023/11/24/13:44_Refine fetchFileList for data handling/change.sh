#!/bin/sh
set -e
goal="Refine fetchFileList for data handling"
echo "Plan:"
echo "1. Modify fetchFileList.js to handle both array and non-array data using flattenPaths"
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
    // If data is an array, wrap and flatten it
    fileList = flattenPaths({
      type: "dir",
      name: ".",
      children: data
    }, '');
  } else {
    // If data is not an array, process it with flattenPaths
    fileList = flattenPaths(data, '');
  }

  // Call setFileList unconditionally with either processed or raw data
  setFileList(fileList);
}

export default fetchFileList;
EOF
echo "\033[32mDone: $goal\033[0m\n"