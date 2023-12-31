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
