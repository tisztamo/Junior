#!/bin/bash

# creating a new directory for the backend
mkdir -p ./src/backend

# moving server.js to the backend directory
mv ./src/server.js ./src/backend/server.js

# moving servePromptDescriptor.js to the backend directory
mv ./src/servePromptDescriptor.js ./src/backend/servePromptDescriptor.js

# creating new files for refactoring the server.js code
echo "$(cat <<EOF
import express from 'express';
import cors from 'cors';
import { generateHandler, descriptorHandler } from './handlers.js';

const app = express();

app.use(cors());
app.use(express.json());

app.get('/descriptor', descriptorHandler);

app.post('/generate', generateHandler);

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
EOF
)" > ./src/backend/server.js

# creating the handlers.js file in the backend directory
echo "$(cat <<EOF
import processPrompt from '../prompt/promptProcessing.js';
import { servePromptDescriptor } from './servePromptDescriptor.js';

export const generateHandler = async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
};

export const descriptorHandler = servePromptDescriptor;
EOF
)" > ./src/backend/handlers.js

# correcting the file path in servePromptDescriptor.js
echo "$(cat <<EOF
import { readFile } from 'fs/promises';
import path from 'path';

import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export const servePromptDescriptor = async (req, res) => {
  const file = await readFile(path.resolve(__dirname, '../../prompt.yaml'), 'utf-8');
  res.send(file);
};
EOF
)" > ./src/backend/servePromptDescriptor.js

echo "Refactoring complete."
