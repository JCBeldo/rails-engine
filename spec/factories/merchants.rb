FactoryBot.define do 
  factory :merchant do
    name { Faker::Commerce.vendor }
    status { rand(0..1) }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
  end
end