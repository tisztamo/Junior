const generatePrompt = async (notes) => {
  const response = await fetch('http://localhost:3000/generate', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ notes })
  });

  const data = await response.json();

  return data;
};

export { generatePrompt };
