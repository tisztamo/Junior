import process from 'process';

export function getServerPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--server-port='));
  if (portArg) {
    return Number(portArg.split('=')[1]);
  }
  
  if (process.env.JUNIOR_SERVER_PORT) {
    return Number(process.env.JUNIOR_SERVER_PORT);
  }
  
  return 10101;
}
