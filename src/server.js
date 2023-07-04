import express from 'express';
import cors from 'cors';
import processPrompt from './prompt/promptProcessing.js';
import { marked } from 'marked';

const app = express();

app.use(cors());
app.use(express.json());

app.post('/generate', async (req, res) => {
  const { notes } = req.body;
  const { prompt } = await processPrompt(notes);
  const htmlPrompt = marked(prompt);  // Convert markdown to HTML
  res.json({ prompt: htmlPrompt });
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
