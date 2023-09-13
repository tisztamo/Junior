import { setupGitRoutes } from './routes/setupGitRoutes.js';
import { setupPromptRoutes } from './routes/setupPromptRoutes.js';
import { executeHandler } from './handlers/executeHandler.js';
import { configHandler } from './handlers/configHandler.js';
import { setupFilesRoutes } from './routes/setupFilesRoutes.js';  // Added this line

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  setupFilesRoutes(app);  // Added this line
  app.post('/execute', executeHandler);
  app.get('/config', configHandler);
}
