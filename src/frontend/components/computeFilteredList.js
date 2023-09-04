export default function computeFilteredList(searchValue, items, compare, itemCount) {
  const comparisonFunction = compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  return items
    .filter(item => comparisonFunction(item, searchValue) > 0)
    .sort((a, b) => comparisonFunction(b, searchValue) - comparisonFunction(a, searchValue))
    .slice(0, itemCount);
}
