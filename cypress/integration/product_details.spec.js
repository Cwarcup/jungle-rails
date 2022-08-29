describe("Product Details", () => {
	beforeEach(() => {
		cy.visit("/");
	});
	it("should go to the homepage", () => {
		cy.visit("/");
		//  title should include "Jungle"
		cy.title().should("include", "Jungle");
	});

	it("should go to the product details page of the first item", () => {
		cy.get(".products article").first().click();
		//  title should include "Jungle"
		cy.get(".product-detail").should("be.visible");
		cy.get(".product-detail h1").should("have.text", "Scented Blade");
	});
});
