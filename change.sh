#!/bin/sh
# Goal: Remove system prompt print at startup
# Plan:
# 1. Remove the line that prints the system prompt in src/main.js

cat > ./src/main.js << 'EOF'
#!/usr/bin/env node

import { startInteractiveSession } from './interactiveSession/startInteractiveSession.js';
import { api, get_model, rl } from './config.js';

console.log("Welcome to Contributor. Model: " + get_model() + "\n");

startInteractiveSession(rl, api);

export { startInteractiveSession };
EOF