import * as fs from 'fs';
import * as yaml from 'js-yaml';

export const writePromptFile = (filePath: string, data: any) => {
    fs.writeFileSync(filePath, yaml.dump(data), 'utf8');
};
