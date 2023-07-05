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
