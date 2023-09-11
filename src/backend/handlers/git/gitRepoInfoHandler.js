import getRepoInfo from '../../../git/getRepoInfo.js';

export default async function gitRepoInfoHandler(req, res) {
    try {
        const repoInfo = await getRepoInfo();
        res.status(200).send(repoInfo);
    } catch (error) {
        res.status(500).send({ message: 'Error fetching repo info', error });
    }
}
