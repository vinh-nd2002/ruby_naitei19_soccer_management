# FootballPitch.destroy_all

# 100.times do
#   FootballPitch.create!(
#     name: Faker::Company.unique.name,
#     location: Faker::Address.city,
#     length: Faker::Number.decimal(l_digits: 2),
#     width: Faker::Number.decimal(l_digits: 2),
#     capacity: [5, 7, 11].sample,
#     price: (Faker::Number.between(from: 10, to: 99) * 10000),
#     description: Faker::Lorem.paragraph,
#     football_pitch_types: FootballPitch.football_pitch_types[:slot5]
#   )
# end

# User.destroy_all
# 20.times do |n|
#   name = Faker::Name.name
#   email = "user#{n + 1}@gmail.com"
#   password = "Abc12345@"
#   password_confirmation = "Abc12345@"
#   phone = Faker::PhoneNumber.phone_number
#   User.create!(
#     name: name,
#     email: email,
#     password: password,
#     password_confirmation: password,
#     is_activated: true,
#     phone: phone,
#     activation_at: Time.now)
# end

user_ids = User.pluck(:id)
football_pitch_ids = FootballPitch.pluck(:id)

# 100.times do
#   user_id = user_ids.sample
#   football_pitch_id = football_pitch_ids.sample
#   FavoritePitch.create!(user_id: user_id, football_pitch_id: football_pitch_id)
# end


# Booking.destroy_all
# 50.times do
#   user_id = user_ids.sample
#   football_pitch_id = football_pitch_ids.sample
#   Booking.create!(
#     user_id: user_id,
#     football_pitch_id: football_pitch_id,
#     booking_price: (Faker::Number.between(from: 10, to: 99) * 10000),
#     start_at: Time.now,
#     end_at: Time.now + 1*60*60,
#     note: "Hàng dễ vỡ xin nhẹ tay",
#     booking_status: Faker::Number.between(from: 0, to: 5)
#   )
# end

# User.create!(name:  "Admin",
#   email: "admin@gmail.com",
#   phone: "0987654321",
#   password: "Abc12345@",
#   password_confirmation: "Abc12345@",
#   is_admin: true,
#   is_activated: true,
#   activation_at: Time.now
# )

# User.create!(name: "anhthaingd@gmail.com",
#              email: "anhthaingd@gmail.com",
#              password: "Th@ihotboy1",
#              password_confirmation: "Th@ihotboy1",
#              phone: "123",
#              is_admin: true,
#              is_activated: true,
#              activation_at: Time.zone.now)

# 50.times do
# user_id = user_ids.sample
# football_pitch_id = football_pitch_ids.sample
# Booking.create!(
#   user_id: user_id,
#   football_pitch_id: football_pitch_id,
#   booking_price: (Faker::Number.between(from: 10, to: 99) * 10000),
#   start_at: Time.now + (Faker::Number.between(from: 0, to: 5).days),
#   end_at: Time.now + 1*60*60,
#   note: "Hàng dễ vỡ xin nhẹ tay",
#   booking_status: Faker::Number.between(from: 0, to: 5),
#   created_at: Time.now + (Faker::Number.between(from: 0, to: 5).days)
# )
# end

100.times do
  user_id = user_ids.sample
  football_pitch_id = football_pitch_ids.sample
  Review.create!(
    user_id: user_id,
    football_pitch_id: football_pitch_id,
    comment: Faker::Lorem.sentence,
    rating: Faker::Number.between(from: 1, to: 5),
  )
end
