FactoryBot.define do 
  factory :invoice do
    customer_id { rand(1..20) }
    status { rand(0..2) }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
  end
end