import setupTerminalServer from './setupTerminalServer.js';

export default function terminalRoutes(wss) {
  wss.on('connection', (socket) => {
    setupTerminalServer(socket);
  }, { path: '/terminal' });
}
