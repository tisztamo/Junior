function getServerPort() {
  const portArg = process.argv.find(arg => arg.startsWith('--server-port='));
  if (portArg) {
    return parseInt(portArg.split('=')[1], 10);
  }
  return process.env.JUNIOR_SERVER_PORT || 10101;
}

export default getServerPort;
