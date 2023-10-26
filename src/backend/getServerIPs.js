import { networkInterfaces } from 'os';

export function getServerIPs() {
  const nets = networkInterfaces();
  const allIPs = [];

  for (const name of Object.keys(nets)) {
    for (const net of nets[name]) {
      if (net.family === 'IPv4' && !net.internal) {
        allIPs.push(net.address);
      }
    }
  }
  return allIPs;
}
