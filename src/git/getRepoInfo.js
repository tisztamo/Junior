import simpleGit from 'simple-git';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const git = simpleGit();

const getRepoInfo = async () => {
    const remote = await git.getRemotes(true);
    const currentBranch = await git.revparse(['--abbrev-ref', 'HEAD']);
    const rootDir = await git.revparse(['--show-toplevel']);
    const packagePath = path.resolve(rootDir, 'package.json');

    let packageJSON = {};
    try {
        packageJSON = JSON.parse(fs.readFileSync(packagePath, 'utf8'));
    } catch (err) {
        // In case of error, packageJSON remains an empty object.
    }
    
    const tags = await git.tags();
    const workingDir = path.resolve(__dirname, '../../');

    return {
        url: remote[0]?.refs?.fetch || '',
        branch: currentBranch,
        name: packageJSON.name || '',
        description: packageJSON.description || '',
        tags: tags.all,
        workingDir: workingDir
    };
}

export default getRepoInfo;
