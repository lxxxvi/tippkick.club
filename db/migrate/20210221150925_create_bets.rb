class CreatePredictions < ActiveRecord::Migration[6.1]
  def change
    create_table :predictions do |t|
      t.references :user, null: false, index: true
      t.references :game, null: false, index: true
      t.integer :home_team_score, null: true
      t.integer :guest_team_score, null: true
      t.integer :home_team_score_points, null: true
      t.integer :guest_team_score_points, null: true
      t.integer :result_points, null: true
      t.integer :perfect_prediction_bonus_points, null: true
      t.integer :total_points, null: true

      t.index %i[user_id game_id], unique: true
      t.timestamps
    end
  end
end
