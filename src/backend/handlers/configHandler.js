async function configHandler(req, res) {
  // Extract CLI arguments, skipping the first two elements (node path & script name)
  const cliArgs = process.argv.slice(2);
  res.json({ cliArgs });
}

export { configHandler };
