class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :tippkick_id, null: false, index: { unique: true }
      t.integer :members_count, null: false, default: 1

      t.timestamps
    end
  end
end
