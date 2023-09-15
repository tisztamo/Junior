import simpleGit from 'simple-git';

const git = simpleGit();

export default async function commitGit(message) {
    await git.add('.');
    await git.commit(message);
    console.log(`Committed with message: ${message}`);
}
