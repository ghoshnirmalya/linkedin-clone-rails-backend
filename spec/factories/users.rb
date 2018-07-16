FactoryBot.define do
  factory :user do
    id { Faker::Number.number }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::String.random(6) }
  end
end
