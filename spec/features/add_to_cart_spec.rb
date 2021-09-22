require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do
  before :each do
    @category = Category.create! name: 'Electronics'

    10.times do |n|
      @category.products.create!(
        name:  "Auto testing device - passTest0",
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 1,
        price: 99.99
      )
    end
  end

  scenario "The cart shows 1 after an item(s) added to it" do

    visit root_path
    expect(page).to have_content('My Cart (0)')

    first('button.btn').click()

    sleep 2
    save_screenshot

    expect(page).to have_content('My Cart (1)')
  end
end
