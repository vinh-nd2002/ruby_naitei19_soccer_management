class RemoveUniqueIndexFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_index :reviews, :user_id
    remove_index :reviews, :football_pitch_id

    add_index :reviews, :user_id
    add_index :reviews, :football_pitch_id
  end
end
