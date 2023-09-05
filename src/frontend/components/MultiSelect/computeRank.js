const computeRank = (item, searchValue, defaultQuery, comparisonFunction) => {
  const searchValueRank = comparisonFunction(item, searchValue);
  const defaultQueryRank = comparisonFunction(item, defaultQuery);
  return searchValueRank + defaultQueryRank;
};

export default computeRank;
