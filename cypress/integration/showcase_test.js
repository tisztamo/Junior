describe('Showcase Test', () => {
  it('should open the Junior frontend and check if it starts', () => {
    cy.visit('http://localhost:3000')  # assuming the frontend runs on this port
    cy.contains('NavBar')  # this is a very basic assertion, you should enhance it further when you expand on the tests.
  });
});
