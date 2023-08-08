import { promisify } from 'util';
import { exec as execCb } from 'child_process';

const exec = promisify(execCb);

export default async function resetGit() {
  try {
    await executeCommand('git stash -u');

    await executeCommand('git clean -f -d && git reset --hard');

    await executeCommand('git checkout stash@{0} -- prompt.yaml', true);
    await executeCommand('git checkout stash@{0} -- prompt.md', true);

    await executeCommand('git stash drop');
  } catch (err) {
    console.error(`An error occurred: ${err}`);
  }
}

async function executeCommand(command, ignoreErrors = false) {
  try {
    console.log(`Running command: ${command}`);
    const { stdout } = await exec(command);
    console.log(`stdout: ${stdout}`);
  } catch (err) {
    if (!ignoreErrors) {
      throw err;
    }
    console.warn(`An error occurred while executing the command: ${command}. Continuing...`);
  }
}
