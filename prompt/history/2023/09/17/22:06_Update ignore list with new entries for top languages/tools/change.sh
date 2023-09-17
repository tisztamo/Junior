#!/bin/sh
set -e
goal="Update ignore list with new entries for top languages/tools"
echo "Plan:"
echo "1. Modify getIgnoreList.js to include new default ignore entries for top languages/tools."
cat > ./src/backend/fileutils/getIgnoreList.js << 'EOF'
function getIgnoreList() {
  const DEFAULT_IGNORE = [
    '.git',
    'node_modules',
    './prompt',
    'dist',
    'build',
    'tmp',
    'temp',
    '.vscode',
    '.idea',
    'coverage',
    '.env',
    '.DS_Store',
    'logs',
    'package-lock.json',
    'yarn.lock',
    '*.pyc',
    '__pycache__',
    '.venv',
    'venv',
    'target',
    '*.class',
    '*.exe',
    '*.test',
    'vendor/',
    '*.gem',
    '.bundle',
    'Gemfile.lock',
    'Cargo.lock',
    'bin/',
    'obj/',
    '*.suo',
    '*.user',
    '*.xcodeproj',
    '*.xcworkspace',
    'Pods/',
    'pubspec.lock',
    '.dart_tool/',
    'out/',
    '*.tsbuildinfo',
    '*.Rproj.user',
    '*.Rhistory',
    '*.pl~',
    'cpanfile.snapshot',
    'project/',
    'dist/',
    '*.hi',
    '_build/',
    'deps/',
    '*.log',
    '*.asv'
  ];

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
EOF
echo "\033[32mDone: $goal\033[0m\n"