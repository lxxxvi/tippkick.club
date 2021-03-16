class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :uefa_game_id, null: false
      t.string :venue, null: false
      t.string :tournament_phase, null: false
      t.string :home_team_name, null: true
      t.string :guest_team_name, null: true
      t.integer :home_team_score, null: false, default: 0
      t.integer :guest_team_score, null: false, default: 0
      t.datetime :kickoff_at, null: false
      t.datetime :final_whistle_at, null: true
      t.integer :max_total_points, null: true

      t.index %i[tournament_phase home_team_name guest_team_name],
              unique: true,
              name: 'index_phase_home_guest'
      t.index %i[uefa_game_id], unique: true
      t.timestamps
    end
  end
end
