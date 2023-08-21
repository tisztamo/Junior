import * as fs from 'fs';
import * as yaml from 'js-yaml';
import { PromptFile } from './types';

export const readPromptFile = (filePath: string): PromptFile => {
    return yaml.load(fs.readFileSync(filePath, 'utf8')) as PromptFile;
};
