import express from 'express';
import cors from 'cors';
import { generateHandler, descriptorHandler, taskUpdateHandler } from './handlers.js';
import { listTasks } from './listTasks.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  app.get('/descriptor', descriptorHandler);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

  app.post('/generate', generateHandler);
  app.post('/updatetask', taskUpdateHandler);

  app.listen(3000, () => {
    console.log('Server is running on port 3000');
  });
}
