import simpleGit from 'simple-git';

const git = simpleGit();

const gitStatus = async () => {
  try {
    const status = await git.status();
    return status;
  } catch (error) {
    console.error();
    throw error;
  }
}

export default gitStatus;
