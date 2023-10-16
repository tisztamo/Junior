import simpleGit from 'simple-git';

const git = simpleGit();

const getGitHistory = async () => {
  try {
    const log = await git.log({ to: await git.latestTag() });
    return log.all.map(commit => commit.message).join('\n');
  } catch (err) {
    console.error(`An error occurred while fetching git history: ${err}`);
    return "";
  }
}

export default getGitHistory;
