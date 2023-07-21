import git from 'simple-git';

export default async function resetGit() {
  const gitInstance = git();

  // Stash all changes including untracked files
  await gitInstance.stash(['-u']);

  // Clean the repository and reset to the latest commit
  await gitInstance.clean('f', ['-d']);
  await gitInstance.reset('hard');

  // Checkout only prompt.yaml from stash
  await gitInstance.checkout('stash@{0} -- prompt.yaml');

  // Drop the stash
  await gitInstance.stash(['drop']);
}
