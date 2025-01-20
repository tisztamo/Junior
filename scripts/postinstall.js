import { execSync } from 'child_process';

/**
 * Validates the prebuilt binaries for node-pty-prebuilt-multiarch.
 * Exits the process if validation fails.
 */
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

validateNodePty();
