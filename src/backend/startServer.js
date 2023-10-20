import express from 'express';
import cors from 'cors';
import { createServer } from 'http';
import { setupRoutes } from './setupRoutes.js';
import { websocketSetup } from './websocketSetup.js';
import { serverSetup } from './serverSetup.js';

export function startServer() {
  const app = express();

  app.use(cors());
  app.use(express.json());

  const server = createServer(app);

  websocketSetup(server);

  setupRoutes(app);

  serverSetup(server);
}
