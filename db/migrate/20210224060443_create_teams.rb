class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :active_members, null: false, default: 1

      t.timestamps
    end
  end
end
