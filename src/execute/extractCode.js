
function extractCode(res) {
  const match = res.match(/```sh([\s\S]*?)```/);
  return match ? match[1].trim() : null;
}

export { extractCode };
