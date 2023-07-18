import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { WebSocketServer } from 'ws';
import { generateHandler, descriptorHandler, taskUpdateHandler } from './handlers.js';
import { listTasks } from './listTasks.js';
import { notifyOnFileChange } from './notifyOnFileChange.js';

export function startServer() {
  console.log(process.cwd())
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);
  const wss = new WebSocketServer({ server });

  notifyOnFileChange(wss);

  app.get('/descriptor', descriptorHandler);
  app.get('/tasks', (req, res) => res.json({ tasks: listTasks() }));

  app.post('/generate', generateHandler);
  app.post('/updatetask', taskUpdateHandler);

  server.listen(3000, () => {
    console.log('Server is running on port 3000');
  });
}
