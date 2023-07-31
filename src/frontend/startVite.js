import path from 'path';
import { fileURLToPath } from 'url';
import { createServer } from 'vite';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const projectRoot = path.resolve(__dirname, '../..');

export async function startVite() {
  const server = await createServer({
    root: projectRoot + '/src/frontend',
    server: {
      open: true,
    },
  });
  await server.listen();
  server.printUrls();
}
