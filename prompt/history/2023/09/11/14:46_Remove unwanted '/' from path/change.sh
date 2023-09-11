#!/bin/sh
set -e
goal="Remove unwanted '/./' from path"
echo "Plan:"
echo "1. Modify the flattenPaths function in src/frontend/service/helpers/flattenPaths.js to avoid adding '/./' to paths."

cat > src/frontend/service/helpers/flattenPaths.js << 'EOF'
const flattenPaths = (node, path = '') => {
  if (node.type === 'file') {
    return [path ? `${path}/${node.name}` : node.name];
  }
  if (!Array.isArray(node.children)) {
    return [];
  }
  return node.children.reduce((acc, child) => {
    return acc.concat(flattenPaths(child, path ? `${path}/${node.name}` : node.name));
  }, []);
};

export default flattenPaths;
EOF

echo "\033[32mDone: $goal\033[0m\n"