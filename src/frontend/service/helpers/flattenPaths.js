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
