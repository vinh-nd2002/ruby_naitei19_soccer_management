class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.string :name
      t.integer :type
      t.decimal :value
      t.integer :usage_count
      t.integer :total_usage
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
