import simpleGit from 'simple-git';

const git = simpleGit();

const resetGit = async () => {
  try {
    console.log("Running command: git clean -f -d");
    await git.clean('f', ['-d']);
    console.log("Running command: git reset --hard");
    await git.reset('hard');
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

export default resetGit;
