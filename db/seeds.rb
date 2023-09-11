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

150.times do
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

User.create!(name:  "Admin",
  email: "admin@gmail.com",
  phone: "0987654321",
  password: "Abc12345@",
  password_confirmation: "Abc12345@",
  is_admin: true,
  is_activated: true,
  activation_at: Time.zone.now
)

# Generate a bunch of additional users.

20.times do |n|
  name = Faker::Name.name
  email = "user#{n + 1}@gmail.com"
  password = "Abc12345@"
  password_confirmation = "Abc12345@"
  phone = Faker::PhoneNumber.phone_number
  admin = (n % 4 == 0)
  user = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    is_activated: true,
    is_admin: admin,
    phone: phone,
    activation_at: Time.zone.now)
end
