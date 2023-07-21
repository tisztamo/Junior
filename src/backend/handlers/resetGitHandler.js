import resetGit from '../../git/resetGit.js';

export default async function resetGitHandler(req, res) {
  try {
    await resetGit();
    res.status(200).send({ message: 'Git successfully reset' });
  } catch (error) {
    res.status(500).send({ message: 'Error in resetting Git', error });
  }
}
