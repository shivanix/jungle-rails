#Used this command to generate product_spec file
#  rails generate rspec:model Product


require 'rails_helper'

RSpec.describe Product, type: :model do

  test_category = Category.new(name: "Product test category")
  subject do
    described_class.new(
      name:        "Product test name",
      price: 1234,
      quantity:    99988,
      category:    test_category
    )
  end
# Also refer and check in schema.rb
  describe 'Validations' do
    
    it "valid with valid attributes" do
      expect(subject).to be_valid
    end
    
    it "invalid with missing name" do
      subject.name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Name can't be blank")
    end
    
    it "invalid with missing price" do
      subject.price_cents = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Price can't be blank")
    end

    it "invalid with missing quantity" do
      subject.quantity = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Quantity can't be blank")
    end

    it "invalid with missing category" do
      subject.category = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include("Category can't be blank")
    end
  end
end
