import { promisify } from 'util';
import { exec } from 'child_process';

const execAsync = promisify(exec);

export default async function gitStatus() {
  try {
    const { stdout, stderr } = await execAsync('git status');
    return stdout;
  } catch (error) {
    console.error(`exec error: ${error}`);
    throw error;
  }
}
