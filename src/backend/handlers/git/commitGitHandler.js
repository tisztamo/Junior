import commitGit from '../../../git/commitGit.js';

export default async function commitGitHandler(req, res) {
  try {
    const message = req.body.message;
    const tags = req.body.tags;
    
    if (!message) {
      res.status(400).send({ message: 'Commit message is required' });
      return;
    }

    let finalMessage = message;
    if (tags && tags.trim() !== "") {
      finalMessage = `${message} ${tags}`;
    }
    
    await commitGit(finalMessage);
    res.status(200).send({ message: `Successfully committed with message: ${finalMessage}` });
  } catch (error) {
    res.status(500).send({ message: 'Error in committing changes', error });
  }
}
