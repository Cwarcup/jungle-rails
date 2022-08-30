describe("User login", () => {
	beforeEach(() => {
		cy.visit("/");
	});

	it("should click on the text containing 'Login'", () => {
		cy.get("a").contains("Login").click({ force: true });
	});

	it("should enter email and password at /login", () => {
		cy.visit("/login");

		// enter email
		cy.get("input[name='email']").type("john@email.com");

		// enter password
		cy.get("input[name='password']").type("12345678");

		// click on the button containing 'Submit'
		cy.get("input[name='commit']").click({ force: true });

		// check if the user is logged in
		cy.get("a").contains("Logout").should("be.visible");
		// check that the user is redirected to the homepage
		cy.get("a").contains("Logout").click({ force: true });
	});

	it("should enter email and password at /login and be redirected to homepage", () => {
		cy.visit("/login");

		// enter email
		cy.get("input[name='email']").type("john@email.com");

		// enter password
		cy.get("input[name='password']").type("12345678");

		// click on the button containing 'Submit'
		cy.get("input[name='commit']").click({ force: true });

		// check if the user is logged in
		cy.get("a").contains("Logout").should("be.visible");

		// check that the title is "Jungle"
		cy.title().should("include", "Jungle");
	});

	it("should logout if user clicks the logout button after a successful login", () => {
		cy.visit("/login");

		// enter email
		cy.get("input[name='email']").type("john@email.com");

		// enter password
		cy.get("input[name='password']").type("12345678");

		// click on the button containing 'Submit'
		cy.get("input[name='commit']").click({ force: true });

		// click on the button containing 'Logout'
		cy.get("a").contains("Logout").click({ force: true });
	});
});
