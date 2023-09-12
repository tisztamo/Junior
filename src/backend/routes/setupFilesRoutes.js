import { fileListHandler } from '../handlers/files/fileListHandler.js';
import { fileReadHandler } from '../handlers/files/fileReadHandler.js';

export function setupFilesRoutes(app) {
  app.get('/files/list/', fileListHandler);
  app.get('/files/read/:filepath(*)', fileReadHandler);  // (*) is used to capture everything including slashes
}
