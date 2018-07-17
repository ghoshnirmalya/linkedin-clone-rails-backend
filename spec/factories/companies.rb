FactoryBot.define do
  factory :company do
    id { Faker::Number.number }
    name { Faker::Company.name }
  end
end
