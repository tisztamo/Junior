import { spawn } from 'child_process'

export const executeShellScript = (scriptPath) => {
  return new Promise((resolve, reject) => {
    const process = spawn('bash', ["-x", scriptPath], {
      stdio: 'pipe',
      shell: true
    });

    let scriptOutput = '';

    process.stdout.on('data', (data) => {
      console.log(`${data}`);
      scriptOutput += data;
    });

    process.stderr.on('data', (data) => {
      console.log(`${data}`);
      scriptOutput += data;
    });

    process.on('error', (error) => {
      console.log(`error: ${error.message}`);
      reject(error);
    });

    process.on('close', (code) => {
      if (code !== 0) {
        console.log(`process exited with code ${code}`);
        reject(code);
      } else {
        resolve(scriptOutput);
      }
    });
  });
}