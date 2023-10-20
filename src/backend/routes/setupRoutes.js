import { setupGitRoutes } from './setupGitRoutes.js';
import { setupPromptRoutes } from './setupPromptRoutes.js';
import { executeHandler } from '../handlers/executeHandler.js';
import { configHandler } from '../handlers/configHandler.js';
import { setupFilesRoutes } from './setupFilesRoutes.js';
import { setupStaticRoutes } from './setupStaticRoutes.js';  // Updated path

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  setupFilesRoutes(app);
  app.post('/execute', executeHandler);
  app.get('/config', configHandler);
  setupStaticRoutes(app);
}
