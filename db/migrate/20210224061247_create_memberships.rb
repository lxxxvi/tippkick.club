class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.boolean :coach, null: false, default: false
      t.integer :ranking_position, null: true

      t.index %i[user_id team_id], unique: true
      t.timestamps
    end
  end
end
