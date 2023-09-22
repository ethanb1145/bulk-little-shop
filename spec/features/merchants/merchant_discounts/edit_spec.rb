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
end
