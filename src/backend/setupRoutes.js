import { setupGitRoutes } from './routes/setupGitRoutes.js';
import { setupPromptRoutes } from './routes/setupPromptRoutes.js';
import { executeHandler } from './handlers/executeHandler.js';
import { configHandler } from './handlers/configHandler.js';
import readFileList from './fileutils/readFileList.js';

export function setupRoutes(app) {
  setupPromptRoutes(app);
  setupGitRoutes(app);
  app.post('/execute', executeHandler);
  app.get('/config', configHandler);

  app.get('/files/list/', async (req, res) => {
    const filesList = await readFileList("./");
    res.json(filesList);
  });
}
