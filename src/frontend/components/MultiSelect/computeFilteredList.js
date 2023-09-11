import computeRank from './computeRank';

export default function computeFilteredList(searchValue, items, compare, itemCount, selectedItems = [], defaultQuery = "") {
  const comparisonFunction = compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  
  return items
    .filter(item => !selectedItems.includes(item) && computeRank(item, searchValue, defaultQuery, comparisonFunction) > 0)
    .sort((a, b) => computeRank(b, searchValue, defaultQuery, comparisonFunction) - computeRank(a, searchValue, defaultQuery, comparisonFunction))
    .slice(0, itemCount);
}
