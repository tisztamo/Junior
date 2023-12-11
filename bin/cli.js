#!/usr/bin/env node

import { startInteractiveSession } from '../src/interactiveSession/startInteractiveSession.js';
import { getApi, get_model, rl } from '../src/config.js';

(async () => {
  console.log("Welcome to Junior. Model: " + get_model() + "\\n");
  const api = await getApi();
  startInteractiveSession(rl, api);
})();
