class RemoveUniqueIndexFromFavoritePitches < ActiveRecord::Migration[7.0]
  def change
    remove_index :favorite_pitches, :user_id
    remove_index :favorite_pitches, :football_pitch_id

    # Thêm lại index mà không yêu cầu duy nhất (unique)
    add_index :favorite_pitches, :user_id
    add_index :favorite_pitches, :football_pitch_id
  end
end
