class Review < ApplicationRecord
  # association
  belongs_to :user
  belongs_to :football_pitch

  after_commit :update_rating, on: [:create, :update]

  validates :rating, presence: true, numericality:
            {greater_than_or_equal_to: Settings.reviews.rating_min,
             less_than_or_equal_to: Settings.reviews.rating_max,
             only_integer: true}

  scope :newest, ->{order(created_at: :desc)}

  private
  def update_rating
    average_rating = football_pitch.reviews.average(:rating)
    football_pitch.update_column :average_rating, average_rating
  end
end
