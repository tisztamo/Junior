import gitStatus from '../../git/gitStatus.js';

export default async function gitStatusHandler(req, res) {
  try {
    const status = await gitStatus();
    res.status(200).send({ status });
  } catch (error) {
    res.status(500).send({ message: 'Error in getting Git status', error });
  }
}
