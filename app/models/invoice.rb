class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  enum status: {
    "cancelled" => 0,
    "completed" => 1,
    "in progress" => 2
  }

  def self.not_shipped
    select("invoices.id, invoices.created_at").joins(:invoice_items).where("invoice_items.status != ?", 2).order("created_at asc").distinct
  end

  def date_conversion
    created_at.strftime("%A, %B %d, %Y")
  end

  def customer_name
    "#{customer.first_name} #{customer.last_name}"
  end

  def total_revenue
    invoice_items.sum("quantity * unit_price")/100.00
  end

  def discounted_revenue
    Invoice
    .select("quantity, unit_price, best_percent")
    .from(
      invoice_items.joins(item: {merchant: :discounts})
      .where("invoice_items.quantity >= discounts.quantity_threshold")
      .select("invoice_items.quantity as quantity, invoice_items.unit_price as unit_price, max(discounts.percent) as best_percent")
      .group(:id)
    )
    .sum("((quantity * unit_price) * (1.0 - (best_percent / 100.0)) / 100.0)")
  end
end