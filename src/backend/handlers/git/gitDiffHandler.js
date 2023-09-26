import gitDiff from '../../../git/gitDiff.js';

export default async function gitDiffHandler(req, res) {
  try {
    const diff = await gitDiff();
    res.status(200).send({ data: diff });
  } catch (error) {
    let errorMessage = 'Error in getting Git diff';
    res.status(500).send({ message: errorMessage, error });
  }
}
