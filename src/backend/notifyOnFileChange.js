import WebSocket from 'ws';
import { watchPromptDescriptor } from '../prompt/watchPromptDescriptor.js';

export const notifyOnFileChange = (wss) => {
  watchPromptDescriptor(() => {
    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send('update');
      }
    });
  });
};
