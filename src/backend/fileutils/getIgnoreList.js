function getIgnoreList() {
  const DEFAULT_IGNORE = ['.git', 'node_modules', './prompt'];

  const cliArgs = process.argv.slice(2);
  const cliIgnore = cliArgs
    .filter(arg => arg.startsWith('--ignore='))
    .map(arg => arg.replace('--ignore=', '').split(','))
    .flat();

  const envIgnore = process.env.JUNIOR_IGNORE ? process.env.JUNIOR_IGNORE.split(',') : [];

  const totalIgnore = [...DEFAULT_IGNORE, ...cliIgnore, ...envIgnore];

  const nameIgnore = totalIgnore.filter(item => !item.startsWith('./'));
  const pathIgnore = totalIgnore.filter(item => item.startsWith('./')).map(item => item.slice(2));

  return { nameIgnore, pathIgnore };
}

export default getIgnoreList;

