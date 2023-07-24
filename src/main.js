#!/usr/bin/env node

import { startInteractiveSession } from './interactiveSession/startInteractiveSession.js';
import { getApi, get_model, rl } from './config.js';

(async () => {
  console.log("Welcome to Junior. Model: " + get_model() + "\n");
  const api = await getApi();
  startInteractiveSession(rl, api);
})();

export { startInteractiveSession };
