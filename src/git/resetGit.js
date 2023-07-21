import git from 'simple-git';

export default async function resetGit() {
  const gitInstance = git();

  // Stash changes in prompt.yaml
  await gitInstance.add('./src/prompt.yaml');
  await gitInstance.stash();

  // Clean the repository and reset to the latest commit
  await gitInstance.clean('f', ['-d']);
  await gitInstance.reset('hard');

  // Apply stashed changes to prompt.yaml
  await gitInstance.stash(['pop']);
}
