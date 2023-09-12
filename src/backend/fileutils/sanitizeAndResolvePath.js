import path from 'path';

export function sanitizeAndResolvePath(relativePath) {
  if (typeof relativePath !== 'string') {
    throw new Error('Invalid path provided');
  }
  
  // Normalize the path to resolve '..' and '.' segments
  let normalizedPath = path.normalize(relativePath);
  
  // Avoid any path that tries to go outside the current directory
  if (normalizedPath.startsWith('..') || normalizedPath === '..') {
    throw new Error('Invalid path provided');
  }
  
  return path.join(process.cwd(), normalizedPath);
}
