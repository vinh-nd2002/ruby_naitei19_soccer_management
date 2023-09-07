class RemoveUniqueIndexFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_index :bookings, :user_id
    remove_index :bookings, :football_pitch_id
    remove_index :bookings, :discount_id
    # Thêm lại index mà không yêu cầu duy nhất (unique)
    add_index :bookings, :user_id
    add_index :bookings, :football_pitch_id
  end
end
