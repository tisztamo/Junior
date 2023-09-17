import isRepo from './isRepo.js';
import initRepo from './initRepo.js';

export default async function checkAndInitRepo() {
    const repoExists = await isRepo();
    if (!repoExists) {
        await initRepo();
    }
}
