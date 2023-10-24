import simpleGit from 'simple-git';
import fs from 'fs';
import path from 'path';

const git = simpleGit();

const extractProjectNameFromURL = (url) => {
    const match = /\/([^/]+)\.git$/.exec(url);
    return match ? match[1] : '';
};

const getRepoInfo = async () => {
    const remote = await git.getRemotes(true);
    const currentBranch = await git.revparse(['--abbrev-ref', 'HEAD']);
    const rootDir = await git.revparse(['--show-toplevel']);
    const packagePath = path.resolve(rootDir, 'package.json');

    let packageJSON = {};
    let projectName = '';

    try {
        packageJSON = JSON.parse(fs.readFileSync(packagePath, 'utf8'));
        projectName = packageJSON.name || '';
    } catch (err) {
        // In case of error (e.g., package.json not found), get the project name from the Git URL
        projectName = extractProjectNameFromURL(remote[0]?.refs?.fetch || '');
    }
    
    const tags = await git.tags();
    const workingDir = process.cwd();

    return {
        url: remote[0]?.refs?.fetch || '',
        branch: currentBranch,
        name: projectName,
        description: packageJSON.description || '',
        tags: tags.all,
        workingDir: workingDir
    };
}

export default getRepoInfo;
