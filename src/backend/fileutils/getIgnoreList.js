function getIgnoreList() {
  const DEFAULT_IGNORE = ['.git', 'node_modules', 'prompt'];

  const cliArgs = process.argv.slice(2);
  const cliIgnore = cliArgs
    .filter(arg => arg.startsWith('--ignore='))
    .map(arg => arg.replace('--ignore=', '').split(','))
    .flat();

  const envIgnore = process.env.JUNIOR_IGNORE ? process.env.JUNIOR_IGNORE.split(',') : [];

  return [...DEFAULT_IGNORE, ...cliIgnore, ...envIgnore];
}

export default getIgnoreList;
