#!/bin/sh
set -e
goal="Implement repo info fetcher"
echo "Plan:"
echo "1. Create a new service/fetchers/ directory."
echo "2. Inside fetchers, create a new fetchRepoInfo file."
echo "3. Implement the fetchRepoInfo function inside fetchRepoInfo."
echo "4. Modify RepoInfo.jsx to use the new fetchRepoInfo function from fetchers."

# Step 1: Create service/fetchers/ directory
mkdir -p src/frontend/service/fetchers/

# Step 2: Create fetchRepoInfo inside fetchers
cat > src/frontend/service/fetchers/fetchRepoInfo.js << 'EOF'
import { getBaseUrl } from '../../getBaseUrl';

const fetchRepoInfo = async () => {
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/git/repoinfo`);
  const data = await response.json();
  return data;
};

export default fetchRepoInfo;
EOF

# Step 3: Modify RepoInfo.jsx to use the new fetchRepoInfo function
cat > src/frontend/components/RepoInfo.jsx << 'EOF'
import { createSignal, onCleanup } from 'solid-js';
import fetchRepoInfo from '../service/fetchers/fetchRepoInfo';

const RepoInfo = () => {
    const [repoInfo, setRepoInfo] = createSignal({});

    // Fetch the repo info on component mount and set it to state
    const fetchAndSetRepoInfo = async () => {
        const data = await fetchRepoInfo();
        setRepoInfo(data);
    }

    fetchAndSetRepoInfo();

    return (
        <span class="text-sm font-mono bg-gray-200 dark:bg-gray-700 px-1 py-0.5 mt-2 rounded">
            {repoInfo().name} {repoInfo().branch}
        </span>
    );
};

export default RepoInfo;
EOF

echo "\033[32mDone: $goal\033[0m\n"