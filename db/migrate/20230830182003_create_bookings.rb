class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :user, index: { unique: true }, foreign_keys: true
      t.belongs_to :football_pitch, index: { unique: true }, foreign_keys: true
      t.decimal :booking_price
      t.belongs_to :discount, index: { unique: true }, foreign_keys: true
      t.decimal :used_discount_value
      t.datetime :start_at
      t.datetime :end_at
      t.integer :status
      t.text :note

      t.timestamps
    end
  end
end
