class Booking < ApplicationRecord
  # enum
  enum status: {pending: 0, approve: 1, reject: 2, cancelled: 3,
                expired: 4, refunded: 5}

  # association
  belongs_to :user
  belongs_to :football_pitch
  belongs_to :discount
end
