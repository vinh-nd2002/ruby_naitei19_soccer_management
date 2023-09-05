class FootballPitch < ApplicationRecord
  # association
  has_many :reviews, dependent: :destroy
  has_many :favorite_pitches, dependent: :destroy
  has_many :bookings, dependent: :destroy

  scope :newest, ->{order(created_at: :desc)}

  scope :search_by_name, (lambda {|name|
    where("name LIKE ?", "%#{name}%") if name.present?
  })

  scope :search_by_location, (lambda {|location|
    where("location LIKE ?", "%#{location}%") if location.present?
  })

  scope :search_by_capacity, (lambda {|cap|
    where(capacity: cap) if cap.present?
  })

  scope :search_by_price, (lambda {|min_price, max_price|
    conditions = []
    conditions << "price >= #{min_price}" if min_price.present?
    conditions << "price <= #{max_price}" if max_price.present?
    where(conditions.join(" AND ")) unless conditions.empty?
  })
end
