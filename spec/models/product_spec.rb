require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should not create a new product if name is not present' do
      @category = Category.new(name: 'Test category')
      @product = Product.new(
        name: nil,
        quantity: 42,
        price_cents: 666,
        category: @category
      )
      expect(@product.valid?).to be(false)
      expect(@product.errors[:name]).to match(["can't be blank"])
    end
    
    it 'should create a new product if all fields are completed' do
      @category = Category.new(name: 'Test category')
      @product = Product.new(
        name: 'Man-bun tie',
        quantity: 42,
        price_cents: 666,
        category: @category
      )
      expect(@product.valid?).to be(true)
    end

    it 'should not create a new product if quantity is not present' do
      @category = Category.new(name: 'Test category')
      @product = Product.new(
        name: 'Man-bun tie',
        quantity: nil,
        price_cents: 666,
        category: @category
      )
      expect(@product.valid?).to be(false)
      expect(@product.errors[:quantity]).to match(["can't be blank"])
    end

    it 'should not create a new product if category is not present' do
      @product = Product.new(
        name: 'Man-bun tie',
        quantity: 42,
        price_cents: 555,
        category: nil
      )
      expect(@product.valid?).to be(false)
      expect(@product.errors[:category]).to match(["can't be blank"])
    end

    it 'should not create a new product if price is not present' do
      @category = Category.new(name: 'Test category')
      @product = Product.new(
        name: 'Man-bun tie',
        quantity: 42,
        price_cents: nil,
        category: @category
      )
      expect(@product.valid?).to be(false)
      expect(@product.errors[:price_cents]).to match(["is not a number"])
    end

  end
end