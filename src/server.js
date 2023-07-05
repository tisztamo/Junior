import express from 'express';
import cors from 'cors';
import processPrompt from './prompt/promptProcessing.js';
import { servePromptDescriptor } from './servePromptDescriptor.js';

const app = express();

app.use(cors());
app.use(express.json());

app.get('/descriptor', servePromptDescriptor);

app.post('/generate', async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  res.json({ prompt: prompt });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
