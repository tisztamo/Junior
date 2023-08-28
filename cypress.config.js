import { defineConfig } from "cypress";

export default defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
    testFiles: "cypress/e2e/**/*.cy.{js,jsx,ts,tsx}",
  },
});
