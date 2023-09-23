require 'rails_helper'

RSpec.describe "Merchant Discount Edit Page", type: :feature do
  before :each do 
    load_test_data
    @discount = @merchant.discounts.create(percent: 20, quantity_threshold: 2)
    @discount2 = @merchant.discounts.create(percent: 10, quantity_threshold: 1)
  end

  it "has fields to fill in that are already pre-populated with discount attributes" do 

    visit edit_merchant_discount_path(@merchant, @discount)

    within('.edit_form') do 
      expect(page).to have_field("Percent")
      expect(page).to have_field("Quantity threshold")
      expect(find_field("Percent").value).to eq("#{@discount.percent}")
      expect(find_field("Quantity threshold").value).to eq("#{@discount.quantity_threshold}")
    end
  end

  it "when info is edited submitted, user is redirected to discount show page with attribute change applied" do 

    visit edit_merchant_discount_path(@merchant, @discount)

    within('.edit_form') do
      fill_in "Percent", with: "30"
      fill_in "Quantity threshold", with: "3"
    end
    
    click_button("Submit")
    expect(page).to have_current_path(merchant_discount_path(@merchant, @discount))
    
    within('.discount_attributes') do
      expect(page).to have_content("Discount ID:")
      expect(page).to have_content(@discount.id)
      expect(page).to have_content("Discount Percentage:")
      expect(page).to have_content("30.0")
      expect(page).to have_content("Discount Quantity Threshold:")
      expect(page).to have_content("3")
    end
  end

  it "when info is edited but not valid, user is redirected to same edit page with message to fill it in" do 

    visit edit_merchant_discount_path(@merchant, @discount)

    within('.edit_form') do
      fill_in "Percent", with: " "
      fill_in "Quantity threshold", with: "3"
    end
    
    click_button("Submit")
    expect(page).to have_current_path(merchant_discount_path(@merchant, @discount))
    expect(page).to have_content("Fill in all fields.")
  end
end
