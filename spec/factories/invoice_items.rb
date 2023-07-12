FactoryBot.define do 
  factory :invoice_item do
    item_id { rand(1..20) }
    invoice_id { rand(1..20) }
    quantity { rand(1..5) }
    unit_price { Faker::Number.number(digits: 5) }
    status { rand(0..2) }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
  end
end