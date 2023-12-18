import { setupGitRoutes } from './setupGitRoutes.js';
import { setupPromptRoutes } from './setupPromptRoutes.js';
import { configHandler } from '../handlers/configHandler.js';
import { setupFilesRoutes } from './setupFilesRoutes.js';
import { setupStaticRoutes } from './setupStaticRoutes.js';

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  setupFilesRoutes(app);
  app.get('/config', configHandler);
  setupStaticRoutes(app);
}
