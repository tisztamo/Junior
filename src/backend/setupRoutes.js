import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './handlers/servePromptDescriptor.js';
import { listTasks } from './handlers/listTasks.js';
import { executeHandler } from './handlers/executeHandler.js';
import gitStatusHandler from './handlers/git/gitStatusHandler.js';
import commitGitHandler from './handlers/git/commitGitHandler.js';
import resetGitHandler from './handlers/git/resetGitHandler.js';
import updateRequirementsHandler from './handlers/updateRequirementsHandler.js';
import { updateTaskHandler } from './handlers/updateTaskHandler.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.post('/generate', generateHandler);
  app.post('/execute', executeHandler);
  app.get('/git/status', gitStatusHandler);
  app.post('/git/reset', resetGitHandler);
  app.post('/git/commit', commitGitHandler);
  app.post('/requirements', updateRequirementsHandler);
  app.post('/updatetask', updateTaskHandler);
}
