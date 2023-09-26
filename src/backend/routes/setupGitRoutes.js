import gitStatusHandler from '../handlers/git/gitStatusHandler.js';
import commitGitHandler from '../handlers/git/commitGitHandler.js';
import resetGitHandler from '../handlers/git/resetGitHandler.js';
import gitRepoInfoHandler from '../handlers/git/gitRepoInfoHandler.js';
import gitDiffHandler from '../handlers/git/gitDiffHandler.js';

export function setupGitRoutes(app) {
    app.get('/git/status', gitStatusHandler);
    app.get('/git/repoinfo', gitRepoInfoHandler);
    app.get('/git/diff', gitDiffHandler);
    app.post('/git/reset', resetGitHandler);
    app.post('/git/commit', commitGitHandler);
}
