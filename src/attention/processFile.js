import fs from 'fs'
import path from 'path'
import util from 'util'

const readFile = util.promisify(fs.readFile)

export const processFile = async (root, p) => {
  const fullPath = path.join(root, p)
  try {
    const content = await readFile(fullPath, "utf8")
    return `${p}:\n\`\`\`\n${content}\n\`\`\`\n`
  } catch (error) {
    return `${p}: err!\n`
  }
}
