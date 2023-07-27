import path from 'path';
import url from 'url';

const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const getPromptDirectories = () => {
  const rootDir = path.resolve();
  const workingDir = process.cwd();
  
  return [
    path.join(path.resolve(__dirname, '../../'), 'prompt'),
    path.join(workingDir, 'prompt')
  ];
}

export { getPromptDirectories };
