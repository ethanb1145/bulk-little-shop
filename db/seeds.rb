# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do
  Merchant.create(
    name: Faker::Company.name
  )
end
  
  
20.times do
  Item.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    unit_price: Faker::Commerce.price(range: 1..100.0, as_string: false),
    merchant_id: Merchant.pluck(:id).sample,
    status: [0, 1].sample
  )
end

20.times do
  Discount.create(
    percent: Faker::Number.decimal(l_digits: 2),
    quantity_threshold: Faker::Number.between(from: 1, to: 20),
    merchant_id: Merchant.pluck(:id).sample
  )
end

10.times do
  Customer.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

30.times do
  Invoice.create(
    status: [0, 1].sample,
    customer_id: Customer.pluck(:id).sample
  )
end

50.times do
  InvoiceItem.create(
    quantity: Faker::Number.between(from: 1, to: 10),
    unit_price: Faker::Commerce.price(range: 1..100.0, as_string: false),
    status: [0, 1].sample,
    invoice_id: Invoice.pluck(:id).sample,
    item_id: Item.pluck(:id).sample
  )
end

40.times do
  Transaction.create(
    credit_card_number: Faker::Finance.credit_card,
    credit_card_expiration_date: Faker::Business.credit_card_expiry_date,
    result: [0, 1].sample,
    invoice_id: Invoice.pluck(:id).sample
  )
end