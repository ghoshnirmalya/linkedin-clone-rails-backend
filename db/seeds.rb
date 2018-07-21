# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
100.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: Faker::String.random(6),
  )
end

# Companies
100.times do
  Company.create(
    name: Faker::Company.name,
  )
end

# Jobs
100.times do
  Job.create(
    title: Faker::Job.title,
    description: Faker::Job.field,
    company_id: Faker::Number.number(1),
  )
end
