import express from 'express';
import cors from 'cors';
import { createPrompt } from './prompt/createPrompt.js';
import { saveAndSendPrompt } from './interactiveSession/saveAndSendPrompt.js';
import { api } from './config.js'; // Import your api object

const app = express();

// Enable CORS for all routes
app.use(cors());

app.use(express.json());

app.post('/generate', async (req, res) => {
  const { notes } = req.body;
  const { prompt, saveto } = await createPrompt(notes);
  const result = await saveAndSendPrompt(prompt, saveto, null, api); // pass the api object here
  res.json({ prompt: result });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
