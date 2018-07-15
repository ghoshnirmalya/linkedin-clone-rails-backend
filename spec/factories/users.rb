FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::email.name }
  end
end
