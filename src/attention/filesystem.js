// filesystem - Provides utility functions to process paths in a filesystem.
// It has two main functionalities:
// - If a path points to a file, the module reads and displays the content of the file.
// - If a path points to a directory, the module lists the files and subdirectories contained in that directory.
// If a problem occurs while processing a particular file or directory, the module prints its name followed by ": err!".

import fs from 'fs'
import path from 'path'
import util from 'util'

const readdir = util.promisify(fs.readdir)
const readFile = util.promisify(fs.readFile)
const stat = util.promisify(fs.stat)

export const processPath = async (root, p) => {
  const fullPath = path.join(root, p)
  try {
    const stats = await stat(fullPath)
    return stats.isDirectory() ? await processDirectory(fullPath) : await processFile(fullPath)
  } catch (error) {
    return `${p}: err!`
  }
}

const processFile = async (p) => {
  try {
    const content = await readFile(p, "utf8")
    return `${p}:\n${content}\n`
  } catch (error) {
    return `${p}: err!\n`
  }
}

const processDirectory = async (p) => {
  try {
    const content = await readdir(p)
    return `${p}:\n${content.join(', ')}\n`
  } catch (error) {
    return `${p}: err!\n`
  }
}
