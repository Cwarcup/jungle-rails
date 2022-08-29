describe("Add item to cart", () => {
	beforeEach(() => {
		cy.visit("/");
	});

	it("should click the 'Add' button on one product from the homepage", () => {
		cy.get("button").contains(" Add ").click({ force: true });
	});

	// it("should increase the cart count by 1", () => {
	// 	cy.get(".products article").first().click();
	// 	cy.get(".product-detail").should("be.visible");
	// 	cy.get(".product-detail h1").should("have.text", "Scented Blade");
	// 	cy.get(".add-to-cart").click();
	// 	cy.get(".cart-count").should("have.text", "1");
	// });
});
