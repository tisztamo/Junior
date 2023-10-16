import fs from 'fs/promises';
import path from 'path';
import getGitHistory from '../src/git/getGitHistory.js';

async function executeGitHistoryRead() {
  try {
    const gitHistory = await getGitHistory();
    const filePath = './tmp/new_commits.md';
    const dir = path.dirname(filePath);
    await fs.mkdir(dir, { recursive: true });
    await fs.writeFile(filePath, gitHistory);
  } catch (err) {
    console.error();
  }
}

executeGitHistoryRead();
