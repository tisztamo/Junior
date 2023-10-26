import getBackendPort from './getBackendPort.js';
import hostConfig from '../config/hostConfig.js';
import { logServerURLs } from './logServerURLs.js';

export function serverSetup(server) {
  const { enabled, ip } = hostConfig();
  const port = getBackendPort();
  
  server.listen(port, ip || (enabled ? '0.0.0.0' : undefined), () => {
    logServerURLs(enabled, ip, port);
  });
}
