import { promises as fs } from 'fs';
import { dirname } from 'path';

export function makeExecutableRollupPlugin() {
  return {
    name: 'make-executable',
    async writeBundle(outputOptions, bundle) {
      for (let fileName of Object.keys(bundle)) {
        if (fileName.endsWith('.js')) {
          const filePath = `${outputOptions.dir}${fileName}`;
          const directoryName = dirname(filePath).split('/').pop();
          if (directoryName === 'bin') {
            // Make the file executable: 0o755 corresponds to rwxr-xr-x
            await fs.chmod(filePath, 0o755);
          }
        }
      }
    }
  };
}
