FactoryBot.define do
  factory :football_pitch do
    name { Faker::Company.unique.name }
    location { Faker::Address.city }
    length { Faker::Number.decimal(l_digits: 2) }
    width { Faker::Number.decimal(l_digits: 2) }
    capacity { [5, 7, 11].sample }
    price { Faker::Number.between(from: 10, to: 99) * 10000 }
    description { Faker::Lorem.paragraph }
    football_pitch_types { FootballPitch.football_pitch_types[:slot5] }
    images { [] }
  end
end
