function getBackendPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--backend-port='));
  if (portArg) {
    return parseInt(portArg.split('=')[1], 10);
  }
  return process.env.JUNIOR_BACKEND_PORT || 10101;
}

export default getBackendPort;
