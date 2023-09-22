function getFrontendPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--frontend-port='));
  if (portArg) {
    return parseInt(portArg.split('=')[1], 10);
  }
  return process.env.JUNIOR_FRONTEND_PORT || 5864;
}

export default getFrontendPort;
