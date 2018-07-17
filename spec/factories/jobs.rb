FactoryBot.define do
  factory :job do
    id { Faker::Number.number }
    title { Faker::Job.title }
    description { Faker::Job.field }

    association :company
  end
end
