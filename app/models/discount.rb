class Discount < ApplicationRecord
  # enum
  enum type: {fixed: 0, percentage: 1}

  # association
  has_many :bookings, dependent: :nullify
end
