import clearBranches from '../src/git/clearBranches.js';

clearBranches().catch(err => {
  console.error(`Failed to clear branches: ${err}`);
});
