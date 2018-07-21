FactoryBot.define do
  factory :message do
    body "MyText"
    conversation nil
    user nil
    read false
  end
end
