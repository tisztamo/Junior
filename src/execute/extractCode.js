function extractCode(res) {
  const match = res.match(/```(sh|bash)([\s\S]*?)```/);
  return match ? match[2].trim() : null;
}

export { extractCode };
