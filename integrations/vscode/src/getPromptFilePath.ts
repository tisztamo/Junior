import * as path from 'path';

export const getPromptFilePath = (rootFolder: string) => {
    return path.join(rootFolder, 'prompt.yaml');
};
