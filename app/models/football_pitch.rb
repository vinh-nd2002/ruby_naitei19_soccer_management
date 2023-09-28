class FootballPitch < ApplicationRecord
  # enum
  enum football_pitch_types: {slot5: 0, slot7: 1, slot10: 2}

  attr_accessor :max_price, :min_price

  # association
  has_many :reviews, dependent: :destroy
  has_many :favorite_pitches, dependent: :destroy
  has_many :users, through: :favorite_pitches
  has_many :favorited_by_users, through: :favorite_pitches, source: :user
  has_many :bookings, dependent: :destroy
  has_many_attached :images

  # scope
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

  # nested attributes
  accepts_nested_attributes_for :bookings, allow_destroy: true
  accepts_nested_attributes_for :reviews, allow_destroy: true
  accepts_nested_attributes_for :favorite_pitches, allow_destroy: true

  # validate
  validates :name, presence: true, length: {maximum: Settings.users.max_name}
  validates :location, presence: true,
            length: {maximum: Settings.users.max_text}
  validates :length, presence: true,
            numericality: {greater_than: Settings.pitches.min_length}
  validates :width, presence: true,
            numericality: {greater_than: Settings.pitches.min_length}
  validates :capacity, presence: true,
            length: {maximum: Settings.users.max_text}
  validates :price, presence: true,
            numericality: {greater_than: Settings.pitches.min_length}
  validates :description, presence: true
  validates :football_pitch_types, presence: true,
            inclusion: {in: FootballPitch.football_pitch_types.keys}
  # validates :images, presence: true

  # class methods

  class << self
    def is_valid_football_pitch? football_pitch
      values_to_check = [:approve, :cancelled, :expired]
      values_to_check.all? do |value|
        football_pitch.bookings.booking_statuses[value].present?
      end
    end

    def ransackable_attributes(*)
      %w(
        average_rating capacity created_at description football_pitch_types
        id length location name price updated_at width min_price max_price
      )
    end

    def ransackable_associations(*)
      %w(
        bookings favorite_pitches favorited_by_users images_attachments
        images_blobs reviews users
      )
    end
  end
end
