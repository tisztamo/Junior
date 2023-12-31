import getProjectRoot from '../backend/fileutils/getProjectRoot.js';
import { cwd } from 'process';

const projectRoot = getProjectRoot();
const currentDir = cwd();

const ejsConfig = {
    async: false,
    root: [currentDir, projectRoot], 
    views: [currentDir, projectRoot]
};

export default ejsConfig;
