#!/usr/bin/env node

import { startInteractiveSession } from './interactiveSession/startInteractiveSession.js';
import { api, get_model, rl } from './config.js';

console.log("Welcome to Junior. Model: " + get_model() + "\n");

startInteractiveSession(rl, api);

export { startInteractiveSession };
