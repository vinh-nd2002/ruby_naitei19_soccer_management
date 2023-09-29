FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "Abc12345@" }
    password_confirmation { "Abc12345@" }
    is_activated { true }
    phone { Faker::PhoneNumber.phone_number }
    activation_at { Time.now }
  end
end
