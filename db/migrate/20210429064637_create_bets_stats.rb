class CreateBetsStats < ActiveRecord::Migration[6.1]
  def change
    create_table :bets_stats do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.references :game, null: false, foreign_key: true
      t.integer :bet_home_team_score, null: false
      t.integer :bet_guest_team_score, null: false
      t.integer :bet_count, null: false

      t.index %i[game_id bet_home_team_score bet_guest_team_score],
              unique: true,
              name: :indx_uniq_game_bets_stats
    end
  end
end
