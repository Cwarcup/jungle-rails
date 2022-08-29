require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should have a name property' do
      product = Product.new
      expect(product.name).to be_nil
    end
    it 'should have a price property' do
      product = Product.new
      expect(product.price).to be_nil
    end
    it 'should have a quantity property' do
      product = Product.new
      expect(product.quantity).to be_nil
    end
    it 'should have a category property' do
      product = Product.new
      expect(product.category).to be_nil
    end

    it 'is a valid product tests presence of name, price, quantity, and category' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Name'
      @product.name = 'Test'
      @product.price_cents = 1234
      @product.quantity = 12
      @product.category = @category

      expect(@product.valid?).to be true
    end

    it 'Name is required' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'
      @product.name = 'Test'
      @product.price_cents = 1234
      @product.quantity = 1
      @product.category = @category

      expect(@product.valid?).to be true
      expect(@product.name).to include('Test')
    end

    it 'When name is not present, it should return an error' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'

      @product.name = nil
      @product.price_cents = 1234
      @product.quantity = 1
      @product.category = @category

      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'price is returned correctly' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'

      @product.name = 'Test'
      @product.price_cents = 1234
      @product.quantity = 1
      @product.category = @category

      expect(@product.price_cents).to be > 0
      expect(@product.price_cents).to be(1234)
    end

    it 'when price is not present, it should return an error' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'
      @product.name = 'Test'
      @product.price_cents = nil
      @product.quantity = 1
      @product.category = @category

      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Price can't be blank")
      expect(@product.price_cents).to be_nil
    end

    it 'quantity is returned correctly' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'
      @product.name = 'Test'
      @product.price_cents = 1234
      @product.quantity = 100
      @product.category = @category

      expect(@product.quantity).to be > 0
      expect(@product.quantity).to be(100)
      expect(@product.quantity).to be_a(Integer)
    end

    it 'when quantity is not present, it should return an error' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'
      @product.name = 'Test'
      @product.price_cents = 1234
      @product.quantity = nil
      @product.category = @category

      expect(@product.quantity).to be_nil
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'category is returned correctly' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'
      @product.name = 'Test'
      @product.price_cents = 1234
      @product.quantity = 1
      @product.category = @category

      expect(@product.category).to be_a(Category)
      expect(@product.category.name).to include('Test Category')
    end

    it 'when category is not present, it should return an error' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'
      @product.name = 'Test'
      @product.price_cents = 1234
      @product.quantity = 1
      @product.category = nil

      expect(@product.category).to be_nil
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

    it 'a category can be present in many products' do
      @product = Product.new
      @category = Category.new
      @category.name = 'Test Category'
      @product.name = 'Test'
      @product.price_cents = 1234
      @product.quantity = 1
      @product.category = @category

      @product2 = Product.new
      @product2.name = 'Test2'
      @product2.price_cents = 12_345
      @product2.quantity = 2
      @product2.category = @category

      expect(@product.category).to be_a(Category)
      expect(@product.category.name).to include('Test Category')

      expect(@product2.category).to be_a(Category)
      expect(@product2.category.name).to include('Test Category')
    end
  end
end
