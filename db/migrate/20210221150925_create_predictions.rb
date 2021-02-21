class CreatePredictions < ActiveRecord::Migration[6.1]
  def change
    create_table :predictions do |t|
      t.references :user, null: false, index: true
      t.references :game, null: false, index: true
      t.integer :home_team_score, null: true
      t.integer :guest_team_score, null: true
      t.integer :points, null: true

      t.index %i[user_id game_id], unique: true
      t.timestamps
    end
  end
end
