import { chmod } from 'fs/promises';

async function makeExecutable(filepath) {
  try {
    await chmod(filepath, '755');
  } catch (err) {
    console.error(`Failed to make ${filepath} executable: ${err}`);
  }
}

export { makeExecutable };
