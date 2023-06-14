import fs from 'fs'
import path from 'path'
import util from 'util'
import { processPath } from './filesystem.js'

const readFile = util.promisify(fs.readFile)

export const readAttention = async (attentionFilePath = "prompt/attention.txt", attentionRootDir = '.') => {
  try {
    const data = await readFile(path.join(attentionRootDir, attentionFilePath), "utf8")
    const lines = data.split("\n")
    const processedLines = await Promise.all(lines.map(line => processPath(attentionRootDir, line.trim())))
    return processedLines.join("\n")
  } catch (error) {
    throw new Error("Attention file is missing or unreadable!")
  }
}
