#!/usr/bin/env node
import { startServer } from '../src/backend/startServer.js';
import { startVite } from '../src/frontend/startVite.js';

startServer();
startVite();
