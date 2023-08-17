import { setupGitRoutes } from './routes/setupGitRoutes.js';
import { setupPromptRoutes } from './routes/setupPromptRoutes.js';
import { executeHandler } from './handlers/executeHandler.js';

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  app.post('/execute', executeHandler);
}
