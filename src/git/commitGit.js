import { exec } from 'child_process';

export default function commitGit(message) {
  return new Promise((resolve, reject) => {
    exec(`git add . && git commit -m "${message}"`, (err, stdout, stderr) => {
      if (err) {
        console.error(`exec error: ${err}`);
        reject(err);
        return;
      }
      console.log(`stdout: ${stdout}`);
      resolve(`Committed with message: ${message}`);
    });
  });
}
