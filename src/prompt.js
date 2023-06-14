// Returns a string to be used as AI prompt, composed of a task description and the current attention

import { readAttention } from "./attention/attention.js"

const createQuery = async (task) => {
  return `Knowledge:
${(await readAttention())}

Task:
${task}`
}

export default createQuery
