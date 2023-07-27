import gitStatus from '../../git/gitStatus.js';

export default async function gitStatusHandler(req, res) {
  try {
    const status = await gitStatus();
    res.status(200).send({ message: status });
  } catch (error) {
    let errorMessage = 'Error in getting Git status';
    if (error.stderr && error.stderr.includes('Not a git repository')) {
      errorMessage = 'Not a git repo. Run \'npx junior-init\' to initialize!';
    }
    res.status(500).send({ message: errorMessage, error });
  }
}
