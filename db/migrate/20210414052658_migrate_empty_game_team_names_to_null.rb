class MigrateEmptyGameTeamNamesToNull < ActiveRecord::Migration[6.1]
  # rubocop:disable Rails/SkipsModelValidations
  def change
    Game.where(home_team_name: '').update_all(home_team_name: nil)
    Game.where(guest_team_name: '').update_all(guest_team_name: nil)
  end
  # rubocop:enable Rails/SkipsModelValidations
end
