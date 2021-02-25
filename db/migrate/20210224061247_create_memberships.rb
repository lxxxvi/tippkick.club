class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :user_group, null: false, foreign_key: true
      t.boolean :admin, null: false, default: false
      t.datetime :accepted_at, null: true

      t.index %i[user_id user_group_id], unique: true
      t.timestamps
    end
  end
end
