import path from 'path';

const getPromptDirectories = () => {
  const rootDir = path.resolve();
  const workingDir = process.cwd();
  
  return [
    path.join(rootDir, 'prompt'),
    path.join(workingDir, 'prompt')
  ];
}

export { getPromptDirectories };
