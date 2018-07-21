FactoryBot.define do
  factory :message do
    body { Faker::Lorem.paragraphs }
    read { Faker::Boolean.boolean }

    association :conversation
    association :user
  end
end
