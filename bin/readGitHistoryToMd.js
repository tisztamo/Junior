#!/usr/bin/env node
import fs from 'fs/promises';
import path from 'path';
import getGitHistory from '../src/git/getGitHistory.js';

function parseArgs() {
  const args = process.argv.slice(2);
  let outputArg;

  for (const arg of args) {
    if (arg.startsWith('--output=')) {
      outputArg = arg.split('=')[1];
      break;
    }
  }

  return {
    output: outputArg || process.env.JUNIOR_NEWS_OUTPUT || './tmp/new_commits.md'
  };
}

async function executeGitHistoryRead() {
  try {
    const { output } = parseArgs();
    const gitHistory = await getGitHistory();
    const dir = path.dirname(output);
    await fs.mkdir(dir, { recursive: true });
    await fs.writeFile(output, gitHistory);
  } catch (err) {
    console.error(err);
  }
}

executeGitHistoryRead();

