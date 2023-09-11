const getComparison = () => {
  return (item, filter) => {
    const filterWords = filter.split(/\s+/).map(word => word.toLowerCase());
    const lowercasedItem = item.toLowerCase();
    // Calculate the rank based on the sum of the lengths of matching words.
    const rank = filterWords.reduce((acc, word) => lowercasedItem.includes(word) ? acc + word.length : acc, 0);
    return rank;
  };
};

export default getComparison;
