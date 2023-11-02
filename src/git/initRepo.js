import simpleGit from 'simple-git';

const git = simpleGit();

export default async function initRepo() {
    console.warn('\x1b[33mInitializing git repo\x1b[0m');
    await git.init();
}
