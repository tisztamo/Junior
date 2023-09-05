const flattenPaths = (node, path) => {
  if (node.type === 'file') {
    return [path + '/' + node.name];
  }
  if (!Array.isArray(node.children)) {
    return [];
  }
  return node.children.reduce((acc, child) => {
    return acc.concat(flattenPaths(child, path + '/' + node.name));
  }, []);
};

export default flattenPaths;
