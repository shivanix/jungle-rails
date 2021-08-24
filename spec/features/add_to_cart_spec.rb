require "rails_helper"

RSpec.feature "ProductDetails", type: :feature, js: true do

  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name:        Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image:       open_asset("apparel1.jpg"),
        quantity:    10,
        price:       64.99
      )
    end
  end

  scenario "Users can add a product to their cart and the page shows this" do

    visit root_path
    page.all(".product button")[0].click
    within "nav" do
      expect(page).to have_content("Cart (1)")
    end

  end

end