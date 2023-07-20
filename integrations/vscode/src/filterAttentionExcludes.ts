import * as glob from 'glob';
import * as path from 'path';
import * as fs from 'fs';

export const filterAttentionExcludes = (windowPaths: string[], excludeList: string[], rootFolder: string) => {
    return windowPaths.filter(windowPath => {
        return !windowPath.endsWith('.git') && windowPath !== 'prompt.yaml' && windowPath !== 'prompt.md' && windowPath !== 'change.sh' && !excludeList.some((pattern) => glob.sync(pattern, { cwd: rootFolder }).includes(windowPath)) && fs.existsSync(path.join(rootFolder, windowPath));
    });
}
