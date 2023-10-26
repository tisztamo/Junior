import { getServerIPs } from './getServerIPs.js';

export function logServerURLs(enabled, ip, port) {
  const orange = "\x1b[38;5;214m";
  const reset = "\x1b[0m";
  const green = "\x1b[32m";
  
  console.log(`${green}Junior is accessible on the following urls:${reset}`);
  console.log();
  if (enabled && !ip) {
    const IPs = getServerIPs();
    IPs.forEach(address => {
        console.log(green, ' ⇒', orange, `http://${address}:${port}`, reset);
    });
  } else if (ip) {
    console.log(green, ' ⇒', orange, `http://${ip}:${port}`, reset);
  } else {
    console.log(green, ' ⇒', orange, `http://localhost:${port}`, reset);
    console.log("Note: Use --host or --host=IP to expose on the network.");
  }
  console.log();
}
