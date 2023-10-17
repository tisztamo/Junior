#!/usr/bin/env node
import resetGit from '../src/git/resetGit.js';

async function executeRollback() {
  try {
    await resetGit();
  } catch (err) {
    console.error();
  }
}

executeRollback();
