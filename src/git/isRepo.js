import simpleGit from 'simple-git';

const git = simpleGit();

export default async function isRepo() {
    return await git.checkIsRepo();
}
