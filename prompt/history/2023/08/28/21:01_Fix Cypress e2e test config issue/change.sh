#!/bin/sh
set -e
goal="Fix Cypress e2e test config issue"
echo "Plan:"
echo "1. Change spec pattern in cypress.config.js to match the expected spec file structure"
echo "2. Rename cypress/integration/showcase_test.js to fit the new spec pattern"
echo "3. Update showcase_test.js to have a single exported function"

# 1. Change spec pattern in cypress.config.js
cat > cypress.config.js << 'EOF'
import { defineConfig } from "cypress";

export default defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
    testFiles: "cypress/e2e/**/*.cy.{js,jsx,ts,tsx}",
  },
});
EOF

# 2. Rename cypress/integration/showcase_test.js to fit the new spec pattern
mkdir -p cypress/e2e
mv cypress/integration/showcase_test.js cypress/e2e/showcase_test.cy.js

# 3. Update showcase_test.js to have a single exported function
cat > cypress/e2e/showcase_test.cy.js << 'EOF'
const showcaseTest = () => {
  describe('Showcase Test', () => {
    it('should open the Junior frontend and check if it starts', () => {
      cy.visit('http://localhost:3000')  // assuming the frontend runs on this port
      cy.contains('NavBar')  // this is a very basic assertion, you should enhance it further when you expand on the tests.
    });
  });
};

export default showcaseTest;
EOF

echo "\033[32mDone: $goal\033[0m\n"