require 'rails_helper'

RSpec.feature "ProductDetails:", type: :feature do

  before :each do
    @category = Category.create! name: 'Electronics'

    10.times do |n|
      @category.products.create!(
        name:  "Auto testing device - passTest0",
        description: Faker::Hipster.paragraph(4),
        image: open_asset('passTest0.jpg'),
        quantity: 1,
        price: 99.99
      )
    end
  end

  scenario "Product details can be seen by a user:" do

    visit root_path
    first('.product-image').click

    sleep 2
    save_screenshot

    expect(page).to have_no_css('.product-detail')
    find('.product a.btn-default', match: :first).click
    expect(page).to have_css('.product-detail')
  end

  
end
