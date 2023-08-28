#!/bin/sh
set -e
goal="Update Cypress config for v10"
echo "Plan:"
echo "1. Update e2e.testFiles to e2e.specPattern in cypress.config.js"

cat << 'EOF' > cypress.config.js
import { defineConfig } from "cypress";

export default defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
    specPattern: "cypress/e2e/**/*.cy.{js,jsx,ts,tsx}",
  },
});
EOF

echo "\033[32mDone: $goal\033[0m\n"