import fs from 'fs';
import util from 'util';
import path from 'path';
const readFile = util.promisify(fs.readFile);

async function resolveTemplateVariables(vars) {
  for (const key in vars) {
    if (typeof vars[key] === 'string' && fs.existsSync(vars[key]) && fs.lstatSync(vars[key]).isFile()) {
      vars[key] = await readFile(path.resolve(vars[key]), 'utf-8');
    }
  }
  return vars;
}

export { resolveTemplateVariables };
