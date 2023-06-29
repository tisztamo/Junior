#!/usr/bin/env node

import { startInteractiveSession } from './interactiveSession/startInteractiveSession.js';
import { api, get_model, getSystemPrompt, rl } from './config.js';

console.log("Welcome to Contributor. Model: " + get_model() + "\n");
console.log("System prompt:", await getSystemPrompt())

startInteractiveSession("", null, rl, api);

export { startInteractiveSession };
