#!/bin/sh
set -e
goal="Refactor RepoInfo for better aesthetics"
echo "Plan:"
echo "1. Update the RepoInfo.jsx component to use less padding, add some margin-top, and make the background adaptable for dark mode."

# Step 1: Update RepoInfo.jsx component

cat > src/frontend/components/RepoInfo.jsx << 'EOF'
import { createSignal } from 'solid-js';

const RepoInfo = () => {
  return (
    <span class="text-sm font-mono bg-gray-200 dark:bg-gray-700 px-1 py-0.5 mt-2 rounded">
      @aijunior/dev main
    </span>
  );
};

export default RepoInfo;
EOF

echo "\033[32mDone: $goal\033[0m\n"
