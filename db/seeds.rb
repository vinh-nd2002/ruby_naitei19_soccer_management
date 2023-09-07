# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Generate fake data using the Faker gem
# Generate FootballPitch

# Clear existing data
FootballPitch.destroy_all

100.times do
  FootballPitch.create(
    name: Faker::Company.unique.name,
    location: Faker::Address.city,
    length: Faker::Number.decimal(l_digits: 2),
    width: Faker::Number.decimal(l_digits: 2),
    capacity: [5, 7, 11].sample,
    price: (Faker::Number.between(from: 10, to: 99) * 10000),
    description: Faker::Lorem.paragraph
  )
end
