import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function resetGit() {
  try {
    await executeCommand('git stash -u');

    await executeCommand('git clean -f -d && git reset --hard');

    await executeCommand('git checkout stash@{0} -- prompt.yaml');
    await executeCommand('git checkout stash@{0} -- prompt.md');

    await executeCommand('git stash drop');
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

async function executeCommand(command) {
  console.log(`Running command: ${command}`);
  const { stdout } = await exec(command);
  console.log(`stdout: ${stdout}`);
}
