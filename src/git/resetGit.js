import git from 'simple-git';

export default async function resetGit() {
  const gitInstance = git();

  // Stash all changes
  await gitInstance.add('./*');
  await gitInstance.stash();

  // Clean the repository and reset to the latest commit
  await gitInstance.clean('f', ['-d']);
  await gitInstance.reset('hard');

  // Checkout only prompt.yaml from stash
  await gitInstance.stash(['apply']);
  await gitInstance.checkout('stash@{0} -- prompt.yaml');

  // Remove stash
  await gitInstance.stash(['drop']);
}
