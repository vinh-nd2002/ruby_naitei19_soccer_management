class Booking < ApplicationRecord
  # enum
  enum booking_status: {pending: 0, approve: 1, reject: 2, cancelled: 3,
                        expired: 4, refunded: 5}, _prefix: :is

  # association
  belongs_to :user
  belongs_to :football_pitch
  belongs_to :discount, optional: true

  scope :newest, ->{order(created_at: :desc)}

  scope :search_by_booking_status, (lambda {|status|
    where(booking_status: status) if status.present?
  })

  scope :search_by_created_at, (lambda {|date|
    where(created_at: date.beginning_of_day..date.end_of_day) if date.present?
  })

  scope :search_by_start_at, (lambda {|date|
    where(start_at: date.beginning_of_day..date.end_of_day) if date.present?
  })

  delegate :name, :phone, to: :user, prefix: true
  delegate :name, :location, to: :football_pitch, prefix: true
end
