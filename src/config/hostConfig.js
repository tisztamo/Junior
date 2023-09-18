import process from 'process';

export default function hostConfig() {
  const hostArg = process.argv.find(arg => arg.startsWith('--host'));

  if (!hostArg) {
    return { enabled: false };
  }

  if (hostArg === '--host') {
    return { enabled: true };
  }

  const ip = hostArg.split('=')[1];
  return { enabled: true, ip };
}
