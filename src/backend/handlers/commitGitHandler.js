import commitGit from '../../git/commitGit.js';

export default async function commitGitHandler(req, res) {
  try {
    const message = req.body.message;
    if (!message) {
      res.status(400).send({ message: 'Commit message is required' });
      return;
    }
    await commitGit(message);
    res.status(200).send({ message: `Successfully committed with message: ${message}` });
  } catch (error) {
    res.status(500).send({ message: 'Error in committing changes', error });
  }
}
