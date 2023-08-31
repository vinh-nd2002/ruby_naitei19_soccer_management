class CreateFavoritePitches < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_pitches do |t|
      t.belongs_to :user, index: { unique: true }, foreign_keys: true
      t.belongs_to :football_pitch, index: { unique: true }, foreign_keys: true

      t.timestamps
    end
  end
end
