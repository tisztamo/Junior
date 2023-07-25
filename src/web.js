#!/usr/bin/env node
import { startServer } from './backend/startServer.js';
import { startVite } from './frontend/startVite.js';

startServer();
startVite();
