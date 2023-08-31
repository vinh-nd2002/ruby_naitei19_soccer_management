class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, index: { unique: true }, foreign_keys: true
      t.belongs_to :football_pitch, index: { unique: true }, foreign_keys: true
      t.text :comment
      t.integer :rating

      t.timestamps
    end
  end
end
