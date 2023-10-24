import path from 'path';
import getProjectRoot from '../backend/fileutils/getProjectRoot.js';

const getPromptDirectories = () => {
  const rootDir = getProjectRoot();
  const workingDir = process.cwd();
  
  return [
    path.join(rootDir, 'prompt'),
    path.join(workingDir, 'prompt')
  ];
}

export { getPromptDirectories };
