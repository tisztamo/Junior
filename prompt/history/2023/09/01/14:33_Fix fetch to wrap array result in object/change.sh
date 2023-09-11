#!/bin/sh
set -e
goal="Fix fetch to wrap array result in object"
echo "Plan:"
echo "1. Modify fetchFileList.js to wrap array results into a specified object."

cat > src/frontend/service/fetchFileList.js << 'EOF'
import { getBaseUrl } from '../getBaseUrl';

async function fetchFileList() {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/files/list`);
  const data = await response.json();

  // Wrap the returned array inside a root object
  if (Array.isArray(data)) {
    return {
      type: "dir",
      name: ".",
      children: data
    };
  }

  return data;
}

export default fetchFileList;
EOF

echo "\033[32mDone: $goal\033[0m\n"