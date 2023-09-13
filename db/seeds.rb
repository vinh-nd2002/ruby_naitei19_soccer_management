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

50.times do
  FootballPitch.create(
    name: Faker::Company.unique.name,
    location: Faker::Address.city,
    length: Faker::Number.decimal(l_digits: 2),
    width: Faker::Number.decimal(l_digits: 2),
    capacity: [5, 7, 11].sample,
    price: (Faker::Number.between(from: 30, to: 99) * 10000),
    description: Faker::Lorem.paragraph,
    football_pitch_types: FootballPitch.football_pitch_types[:slot5]
  )
end

# # Generate a bunch of additional users.

20.times do |n|
  name = Faker::Name.name
  email = "user#{n + 1}@gmail.com"
  password = "Abc12345@"
  password_confirmation = "Abc12345@"
  phone = Faker::PhoneNumber.phone_number
  user = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    is_activated: true,
    phone: phone,
    activation_at: Time.zone.now)
end

# Lấy danh sách tất cả user_ids và football_pitch_ids hiện có
user_ids = User.pluck(:id)
football_pitch_ids = FootballPitch.pluck(:id)

# Sử dụng vòng lặp để tạo ngẫu nhiên favorite_pitches
100.times do
  user_id = user_ids.sample
  football_pitch_id = football_pitch_ids.sample
  FavoritePitch.create!(user_id: user_id, football_pitch_id: football_pitch_id)
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

User.create!(name: "anhthaingd@gmail.com",
             email: "anhthaingd@gmail.com",
             password: "Th@ihotboy1",
             password_confirmation: "Th@ihotboy1",
             phone: "123",
             is_admin: true,
             is_activated: true,
             activation_at: Time.zone.now)
