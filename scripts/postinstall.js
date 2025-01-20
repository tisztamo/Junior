import { installBashIfWindows } from './postinstall/installBashIfWindows.js';
import { execSync } from 'child_process';

export async function validateNodePty() {
  try {
    console.log('Validating prebuilt binaries for node-pty...');
    execSync('node -e "require(\'@homebridge/node-pty-prebuilt-multiarch\')"', { stdio: 'inherit' });
    console.log('Validation successful.');
  } catch (error) {
    console.error('Validation failed. Please check your setup.');
    process.exit(1);
  }
}

await installBashIfWindows();
await validateNodePty();
