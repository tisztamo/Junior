import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function clearBranches(exceptions = []) {
  try {
    const { stdout: currentBranch } = await exec('git rev-parse --abbrev-ref HEAD');
    const { stdout: allBranches } = await exec('git for-each-ref --format="%(refname:short)" refs/heads');

    const branches = allBranches.split('\n').filter(branch => branch !== currentBranch.trim() && !exceptions.includes(branch));

    for (const branch of branches) {
      await executeCommand(`git branch -d ${branch}`);
    }
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

async function executeCommand(command) {
  try {
    console.log(`Running command: ${command}`);
    const { stdout } = await exec(command);
    console.log(`stdout: ${stdout}`);
  } catch (err) {
    throw err;
  }
}
