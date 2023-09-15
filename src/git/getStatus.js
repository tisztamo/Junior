import simpleGit from 'simple-git';

const git = simpleGit();

export default async function getStatus() {
    return await git.status();
}
