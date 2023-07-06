export const fetchDescriptor = async () => {
  const response = await fetch('http://localhost:3000/descriptor');
  const text = await response.text();
  return text;
};
