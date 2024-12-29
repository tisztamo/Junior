import { execSync } from 'child_process';

async function validatePrebuiltBinary() {
  try {
    console.log('Validating prebuilt binaries for node-pty...');
    execSync('node -e "require(\'node-pty-prebuilt-multiarch\')"', { stdio: 'inherit' });
    console.log('Validation successful.');
  } catch (error) {
    console.error('Validation failed. Please check your setup.');
    process.exit(1);
  }
}

validatePrebuiltBinary();
