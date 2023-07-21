import { exec } from 'child_process';

export default function resetGit() {
  // Stash all changes including untracked files
  exec('git stash -u', (err, stdout, stderr) => {
    if (err) {
      console.error(`exec error: ${err}`);
      return;
    }
    console.log(`stdout: ${stdout}`);

    // Clean the repository and reset to the latest commit
    exec('git clean -f -d && git reset --hard', (err, stdout, stderr) => {
      if (err) {
        console.error(`exec error: ${err}`);
        return;
      }
      console.log(`stdout: ${stdout}`);

      // Checkout prompt.yaml from stash
      exec('git checkout stash@{0} -- prompt.yaml', (err, stdout, stderr) => {
        if (err) {
          console.error(`exec error: ${err}`);
          return;
        }
        console.log(`stdout: ${stdout}`);

        // Drop the stash
        exec('git stash drop', (err, stdout, stderr) => {
          if (err) {
            console.error(`exec error: ${err}`);
            return;
          }
          console.log(`stdout: ${stdout}`);
        });
      });
    });
  });
}
