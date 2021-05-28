class RemoveMaxTotalPointsFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :max_total_points, :integer, null: true
  end
end
