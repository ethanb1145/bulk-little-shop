require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  before(:each) do
    load_test_data
  end
  it { should belong_to :invoice }
  it { should belong_to :item }

  describe "instance methods" do
    describe "#find_item" do
      it "finds and returns item associated with and invoice_item" do
        
        expect(@invoice_item1.find_item).to eq(@item7)
      end
    end

    describe "#find_invoice_items" do
      it "returns all invoice_items associated with given invoice" do

        expect(InvoiceItem.find_invoice_items(@invoice11)).to eq([@invoice_item4])
      end
    end

    describe "#item_best_discount" do
      it "gives the best discount for that item" do
        merchant = Merchant.create!(name: "Merchant")
        item = merchant.items.create!(name: "Item", description: "Item", unit_price: 1)
        customer = Customer.create!(first_name: "Cust", last_name: "Omer")
        invoice = customer.invoices.create!(status: 1)
        invoice_item = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 20, status: 0, unit_price: 20)
        discount = Discount.create!(merchant_id: merchant.id, percent: 20, quantity_threshold: 5)
        discount2 = Discount.create!(merchant_id: merchant.id, percent: 15, quantity_threshold: 3)

        expect(invoice_item.item_best_discount).to eq(discount)
      end
    end
  end
end