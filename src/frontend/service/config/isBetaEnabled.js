import cliArgs from './cliArgs';

const isBetaEnabled = async () => {
  const args = await cliArgs();
  return args.includes('--beta');
}

export default isBetaEnabled;
