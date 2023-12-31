import simpleGit from 'simple-git';

const git = simpleGit();

const getGitHistory = async () => {
  try {
    const tags = await git.tags();
    const latestTag = tags.latest;
    const log = await git.log({ to: latestTag });
    return log.all.map(commit => commit.message).join('\n');
  } catch (err) {
    console.error(`An error occurred while fetching git history: ${err}`);
    return "";
  }
}

export default getGitHistory;
