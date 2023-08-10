import clearBranches from '../src/git/clearBranches.js';

const exceptions = process.argv.slice(2);
clearBranches(exceptions).catch(err => {
  console.error(`Failed to clear branches: ${err}`);
});
