#!/bin/sh
set -e
goal="Modify flattenPaths for special path cases"
echo "Plan:"
echo "1. Update flattenPaths to handle '.' and './' paths."
echo "2. Ensure the updated function adheres to ES6 standards."
cat > ./src/frontend/service/helpers/flattenPaths.js << 'EOF'
const flattenPaths = (node, path = '') => {
  if (node.type === 'file') {
    return [(!path || path === '.' || path === './') ? node.name : `${path}/${node.name}`];
  }
  if (!Array.isArray(node.children)) {
    return [];
  }
  return node.children.reduce((acc, child) => {
    const newPath = (!path || path === '.' || path === './') ? node.name : `${path}/${node.name}`;
    return acc.concat(flattenPaths(child, newPath));
  }, []);
};

export default flattenPaths;
EOF
echo "\033[32mDone: $goal\033[0m\n"