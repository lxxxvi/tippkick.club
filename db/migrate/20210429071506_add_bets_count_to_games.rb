class AddBetsCountToGames < ActiveRecord::Migration[6.1]
  def change
    change_table :games, bulk: true do |t|
      t.column :bets_home_team_wins_count, :integer, null: false, default: 0
      t.column :bets_guest_team_wins_count, :integer, null: false, default: 0
      t.column :bets_draw_count, :integer, null: false, default: 0
    end
  end
end
