class User < ApplicationRecord
  # association
  has_many :favorite_pitches, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
end
