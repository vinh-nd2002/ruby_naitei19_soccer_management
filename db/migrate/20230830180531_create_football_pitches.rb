class CreateFootballPitches < ActiveRecord::Migration[7.0]
  def change
    create_table :football_pitches do |t|
      t.string :name
      t.string :location
      t.float :length
      t.float :width
      t.integer :capacity
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end
