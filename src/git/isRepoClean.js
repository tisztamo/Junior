import simpleGit from 'simple-git';

const git = simpleGit();

const isRepoClean = async () => {
  const isRepo = await git.checkIsRepo();

  if (!isRepo) {
    return false;
  }

  const status = await git.status();
  return status.isClean();
}

export default isRepoClean;
