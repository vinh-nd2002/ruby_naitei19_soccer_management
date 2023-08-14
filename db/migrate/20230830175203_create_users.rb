class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password
      t.string :phone
      t.boolean :is_admin
      t.string :password_digest
      t.string :remember_digest
      t.boolean :is_activated, default: false
      t.string :activation_digest
      t.datetime :activation_at
      t.string :reset_digest
      t.string :reset_digest_at

      t.timestamps
    end
  end
end
