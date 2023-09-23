require 'rails_helper'

RSpec.describe "Merchant Discounts Show Page", type: :feature do
  before :each do 
    load_test_data
    @discount = @merchant.discounts.create(percent: 20, quantity_threshold: 2)
    @discount2 = @merchant.discounts.create(percent: 10, quantity_threshold: 1)
  end

  it "when a user visits a discount show page, there are attributes for the discount listed" do 
    visit merchant_discount_path(@merchant, @discount)
    
    within('.discount_attributes') do
      expect(page).to have_content("Discount ID:")
      expect(page).to have_content(@discount.id)
      expect(page).to_not have_content(@discount2.id)
      expect(page).to have_content("Discount Percentage:")
      expect(page).to have_content(@discount.percent)
      expect(page).to have_content("Discount Quantity Threshold:")
      expect(page).to have_content(@discount.quantity_threshold)
    end
  end

  it "has a link that when clicked, directs user to a new page to edit the discount" do 
    visit merchant_discount_path(@merchant, @discount)

    within('.discount_edit_link') do 
      expect(page).to have_link("Edit this Discount")
    end

    click_link("Edit this Discount")
    expect(page).to have_current_path(edit_merchant_discount_path(@merchant, @discount))
  end
end