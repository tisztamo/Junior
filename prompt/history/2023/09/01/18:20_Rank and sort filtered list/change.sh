#!/bin/sh
set -e
goal="Rank and sort filtered list"
echo "Plan:"
echo "1. Modify getComparison.js to return rank: sum of the lengths of matching words."
echo "2. Modify FilteredList.jsx to use the new ranking system for filtering and sorting."

# Update getComparison.js
cat > src/frontend/services/helpers/getComparison.js << 'EOF'
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
EOF

# Update FilteredList.jsx
cat > src/frontend/components/FilteredList.jsx << 'EOF'
const FilteredList = (props) => {
  const comparisonFunction = props.compare || ((item, filter) => item.includes(filter) ? filter.length : 0);
  
  return (
    <ul class="w-full list-disc pl-5">
      {props.items
        // Filter by non-zero ranks.
        .filter(item => comparisonFunction(item, props.filter) > 0)
        // Sort items by rank, highest rank first.
        .sort((a, b) => comparisonFunction(b, props.filter) - comparisonFunction(a, props.filter))
        .slice(0, props.itemCount)
        .map(item => <li key={item}>{item}</li>)}
    </ul>
  );
};

export default FilteredList;
EOF

echo "\033[32mDone: $goal\033[0m\n"