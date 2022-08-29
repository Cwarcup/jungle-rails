describe("Homepage", () => {
	beforeEach(() => {
		cy.visit("/");
	});
	it("should go to the homepage", () => {
		cy.visit("/");
		//  title should include "Jungle"
		cy.title().should("include", "Jungle");
	});
	it("There is products on the page", () => {
		cy.get(".products article").should("be.visible");
	});
});
