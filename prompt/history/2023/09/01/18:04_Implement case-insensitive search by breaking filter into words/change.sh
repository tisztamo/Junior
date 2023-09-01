#!/bin/sh
set -e
goal="Implement case-insensitive search by breaking filter into words"
echo "Plan:"
echo "1. Modify the getComparison function to split the filter into words."
echo "2. Convert both item and filter words to lowercase for case-insensitive comparison."
echo "3. Return true if any of the words from the filter are included in the item."

# Step 1 and 2: Modify the getComparison function
cat > src/frontend/services/helpers/getComparison.js << 'EOF'
const getComparison = () => {
  return (item, filter) => {
    // GOAL OF THE CHANGE: Split the filter into words
    const filterWords = filter.split(/\s+/).map(word => word.toLowerCase());

    // GOAL OF THE CHANGE: Convert the item to lowercase for case-insensitive comparison
    const lowercasedItem = item.toLowerCase();

    // GOAL OF THE CHANGE: Check if any word from the filter is included in the item
    return filterWords.some(word => lowercasedItem.includes(word));
  };
};

export default getComparison;
EOF

echo "\033[32mDone: $goal\033[0m\n"