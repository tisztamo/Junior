import fs from 'fs';
import { ChatGPTAPI } from 'chatgpt';
import { getSystemPrompt } from "../../prompt/getSystemPrompt.js";
import createFakeApi from '../fake/createFakeApi.js';

export default async function createApi(model) {
  let apiKey = process.env.OPENAI_API_KEY;

  if (!apiKey) {
    if (fs.existsSync('./secret.sh')) {
      const secretFileContent = fs.readFileSync('./secret.sh', 'utf-8');
      const match = secretFileContent.match(/export OPENAI_API_KEY=(\S+)/);
      if (match) {
        apiKey = match[1];
      }
    }
  }

  if (!apiKey) {
    console.warn('OPENAI_API_KEY not found, using fake API');
    return createFakeApi();
  }

  const systemMessage = await getSystemPrompt();

  return new ChatGPTAPI({
    debug: true,
    apiKey,
    systemMessage,
    completionParams: {
      model,
      stream: true,
      temperature: 0.5,
      max_tokens: 2048,
    }
  });
}
