import getBackendPort from './getBackendPort.js';
import hostConfig from '../config/hostConfig.js';
import { logServerURLs } from './logServerURLs.js';

export function serverSetup(server) {
  const { enabled, ip } = hostConfig();
  const port = getBackendPort();
  
  // If ip is defined, use it; otherwise, if enabled use '0.0.0.0'; if not enabled, use '127.0.0.1'.
  const listeningIP = ip || (enabled ? '0.0.0.0' : '127.0.0.1');

  server.listen(port, listeningIP, () => {
    logServerURLs(enabled, ip, port);
  });
}
