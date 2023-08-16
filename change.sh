#!/bin/sh
set -e
goal="Update default baseUrl"
echo "Plan:"
echo "1. Update getBaseUrl.js to use the current protocol and host for the default baseUrl."
echo "2. The port should remain as 10101."

# Step 1: Update getBaseUrl.js
cat << 'EOF' > src/frontend/getBaseUrl.js
export const getBaseUrl = () => {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const baseUrl = urlParams.get('baseUrl');

    // Use the current protocol and host for the default baseUrl
    const defaultBaseUrl = `${window.location.protocol}//${window.location.hostname}:10101`;
    return baseUrl || defaultBaseUrl;
};
EOF

echo "\033[32mDone: $goal\033[0m\n"
