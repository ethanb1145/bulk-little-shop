class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: {
    "pending" => 0,
    "packaged" => 1,
    "shipped" => 2
  }

  def find_item
    Item.find(self.item_id)
  end

  def self.find_invoice_items(invoice)
    all.where('invoice_id = ?', invoice.id)
  end

  def item_best_discount
    item.merchant.discounts.where("discounts.quantity_threshold <= ?", quantity).order(percent: :desc).first
  end
end