FactoryBot.define do 
  factory :transaction do
    invoice_id { rand(1..20) }
    credit_card_number { Faker::Number.number(digits: 16).to_s }
    credit_card_expiration_date { Faker::Number.number(digits: 4).to_s }
    result { rand(0..1) }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
  end
end