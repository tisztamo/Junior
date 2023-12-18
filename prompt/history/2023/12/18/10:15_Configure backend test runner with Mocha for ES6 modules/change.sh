#!/bin/sh
set -e
goal="Configure backend test runner with Mocha for ES6 modules"
echo "Plan:"
echo "1. Install Mocha and Chai."
echo "2. Update package.json to include a test script that handles ES6 modules."
echo "3. Add a sample test file using dynamic imports for validation."

# Step 1: Install Mocha and Chai
npm install --save-dev mocha chai

# Step 2: Update package.json
# Update the test script in package.json to run Mocha with specific options
jq '.scripts.test = "mocha --recursive --extension .test.js src/backend/"' package.json > package.json.tmp && mv package.json.tmp package.json

# Step 3: Add a Sample Test File
# Create a sample test file using ES6 imports
mkdir -p src/backend
cat > src/backend/sample.test.js << EOF
import chai from 'chai';
const expect = chai.expect;

describe('Sample Test', function() {
  it('should pass', function() {
    expect(true).to.be.true;
  });
});
EOF

echo "\033[32mDone: $goal\033[0m\n"