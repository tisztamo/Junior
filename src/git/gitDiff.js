import simpleGit from 'simple-git';
import { parse } from 'diff2html';

const git = simpleGit();

const gitDiff = async () => {
  try {
    const diff = await git.diff(['--word-diff=color']);
    const htmlOutput = parse(diff);
    return htmlOutput;
  } catch (error) {
    console.error();
    throw error;
  }
}

export default gitDiff;
