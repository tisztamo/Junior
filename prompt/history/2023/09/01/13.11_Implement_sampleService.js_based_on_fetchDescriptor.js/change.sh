#!/bin/sh
set -e
goal="Implement sampleService.js based on fetchDescriptor.js"
echo "Plan:"
echo "1. Copy the contents of fetchDescriptor.js to a new file named sampleService.js"
echo "2. Modify the new sampleService.js to export the function as a default instead of a named export and to fetch '/sample'"
echo "3. Remove any existing comments"

# Step 1: Copy fetchDescriptor.js to sampleService.js
cp src/frontend/service/fetchDescriptor.js src/frontend/service/sampleService.js

# Step 2: Modify sampleService.js for default export and fetch /sample
cat << 'EOF' > src/frontend/service/sampleService.js
import { getBaseUrl } from '../getBaseUrl';

async function sampleService() { 
  const baseUrl = getBaseUrl();
  const response = await fetch(`${baseUrl}/sample`);
  const text = await response.text();
  return text;
};

export default sampleService;
EOF

echo "\033[32mDone: $goal\033[0m\n"