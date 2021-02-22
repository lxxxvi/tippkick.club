namespace :dev do
  desc 'Shifts kickoff dates to today, as if 3rd group round would start'
  task shift_tournament: :environment do
    raise 'can only run in development' unless Rails.env.development?

    first_unplayed_game = Game.where(final_whistle_at: nil).order(kickoff_at: :asc).limit(1).first

    raise 'first_unplayed_game not found' if first_unplayed_game.nil?

    days_between = (first_unplayed_game.kickoff_at.to_date - Date.today).to_i

    Game.update_all(
      <<~SQL
        kickoff_at       = kickoff_at       - '#{days_between} days'::INTERVAL,
        final_whistle_at = final_whistle_at - '#{days_between} days'::INTERVAL
      SQL
    )
  end
end
