FactoryBot.define do 
  factory :item do
    name { Faker::Commerce.product_name }
    description { "Nostrum doloribus quia. Expedita vitae beatae cumque. Aut ut illo aut eum." }
    unit_price { Faker::Number.number(digits: 5) }
    merchant_id { rand(1..20) }
    status { rand(0..1) }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
  end
end