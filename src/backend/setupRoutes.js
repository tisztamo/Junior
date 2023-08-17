import { generateHandler } from './handlers/generateHandler.js';
import { servePromptDescriptor } from './handlers/servePromptDescriptor.js';
import { updateTaskHandler } from './handlers/updateTaskHandler.js';
import { listTasks } from './handlers/listTasks.js';
import { executeHandler } from './handlers/executeHandler.js';
import gitStatusHandler from './handlers/git/gitStatusHandler.js';
import commitGitHandler from './handlers/git/commitGitHandler.js';
import resetGitHandler from './handlers/git/resetGitHandler.js';

export function setupRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));
  app.get('/git/status', gitStatusHandler);
  app.post('/generate', generateHandler);
  app.post('/updatetask', updateTaskHandler);
  app.post('/execute', executeHandler);
  app.post('/git/reset', resetGitHandler);
  app.post('/git/commit', commitGitHandler);
}
