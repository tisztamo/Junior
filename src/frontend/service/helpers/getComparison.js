const getComparison = () => {
  return (item, filter) => {
    const lowercasedItem = item.toLowerCase();
    // Calculate the rank based on the sum of the lengths of matching words multiplied by their weights.
    const rank = filter.reduce((acc, { keyword, weight }) => {
      return lowercasedItem.includes(keyword) ? acc + (keyword.length * weight) : acc;
    }, 0);
    return rank;
  };
};

export default getComparison;
