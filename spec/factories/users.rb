FactoryBot.define do
  factory :user do
    id { Faker::Number.number }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
  end
end
