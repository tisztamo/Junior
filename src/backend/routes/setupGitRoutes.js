import gitStatusHandler from '../handlers/git/gitStatusHandler.js';
import commitGitHandler from '../handlers/git/commitGitHandler.js';
import resetGitHandler from '../handlers/git/resetGitHandler.js';

export function setupGitRoutes(app) {
  app.get('/git/status', gitStatusHandler);
  app.post('/git/reset', resetGitHandler);
  app.post('/git/commit', commitGitHandler);
}
