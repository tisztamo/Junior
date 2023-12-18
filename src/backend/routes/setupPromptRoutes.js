import { generateHandler } from '../handlers/generateHandler.js';
import { servePromptDescriptor } from '../handlers/servePromptDescriptor.js';
import { listTasks } from '../handlers/listTasks.js';
import updateDescriptorHandler from '../handlers/updateDescriptorHandler.js';
import { updateTaskHandler } from '../handlers/updateTaskHandler.js';
import { promptstotryHandler } from '../handlers/promptstotryHandler.js';
import { executeHandler } from '../handlers/executeHandler.js';  // Added line

export function setupPromptRoutes(app) {
  app.get('/descriptor', servePromptDescriptor);
  app.get('/tasks', listTasks);
  app.post('/generate', generateHandler);
  app.post('/descriptor', updateDescriptorHandler);
  app.post('/updatetask', updateTaskHandler);
  app.get('/promptstotry', promptstotryHandler);
  app.post('/execute', executeHandler);  // Added line
}
