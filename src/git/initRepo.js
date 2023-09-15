import simpleGit from 'simple-git';

const git = simpleGit();

export default async function initRepo() {
    await git.init();
}
