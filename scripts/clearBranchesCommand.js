import clearBranches from '../src/git/clearBranches';

const exceptions = process.argv.slice(2);

async function run() {
  try {
    await clearBranches(exceptions);
    console.log('Branches deleted successfully.');
  } catch (err) {
    console.error(`An error occurred while deleting branches: ${err}`);
    process.exit(1);
  }
}

run();
