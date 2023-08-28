#!/bin/sh
set -e
goal="Setup test runner and showcase test"
echo "Plan:"
echo "1. Install the best test runner for the task."
echo "2. Create a showcase test to open the frontend and check if it starts."

# Step 1: Install the best test runner for the task. We will use 'cypress' for E2E testing.
npm install --save-dev cypress

# Step 2: Create a showcase test to open the frontend and check if it starts.
mkdir -p cypress/integration
cat <<EOF >cypress/integration/showcase_test.js
describe('Showcase Test', () => {
  it('should open the Junior frontend and check if it starts', () => {
    cy.visit('http://localhost:3000')  # assuming the frontend runs on this port
    cy.contains('NavBar')  # this is a very basic assertion, you should enhance it further when you expand on the tests.
  });
});
EOF

# Step 3: Add script to run the tests in package.json (for ease of use later)
PACKAGE_PATH="./package.json"
TMP_PATH="./temp.package.json"

# use jq to add the script command to the package.json
jq '.scripts.test = "cypress open"' $PACKAGE_PATH > $TMP_PATH && mv $TMP_PATH $PACKAGE_PATH

echo "\033[32mDone: $goal\033[0m\n"