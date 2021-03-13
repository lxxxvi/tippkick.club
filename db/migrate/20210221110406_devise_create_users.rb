# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.string :tippkick_id, null: false
      t.string :nickname, null: false
      t.integer :total_points, null: true

      t.timestamps null: false
      t.index :email, unique: true
      t.index :reset_password_token, unique: true
      t.index :tippkick_id, unique: true
      t.index :nickname, unique: true
    end
  end
end
