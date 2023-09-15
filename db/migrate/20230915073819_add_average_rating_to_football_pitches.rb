class AddAverageRatingToFootballPitches < ActiveRecord::Migration[7.0]
  def change
    add_column :football_pitches, :average_rating, :float, default: 0.0
  end
end
