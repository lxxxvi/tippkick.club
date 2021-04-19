namespace :dev do
  desc 'Shifts kickoff dates to today, as if 3rd group round would start'
  task shift_tournament: :environment do
    raise 'can only run in development' unless Rails.env.development?

    first_unplayed_game = Game.where(final_whistle_at: nil).order(kickoff_at: :asc).limit(1).first

    raise 'first_unplayed_game not found' if first_unplayed_game.nil?

    days_between = (first_unplayed_game.kickoff_at.to_date - Time.zone.today).to_i

    Game.update_all( # rubocop:disable Rails/SkipsModelValidations
      <<~SQL.squish
        kickoff_at       = kickoff_at       - '#{days_between} days'::INTERVAL,
        final_whistle_at = final_whistle_at - '#{days_between} days'::INTERVAL
      SQL
    )
  end

  desc 'Create random data for users, groups and memberships'
  task create_random_data: :environment do
    raise 'can only run in development' unless Rails.env.development?
    raise 'tournament has no games' if Game.count.zero?

    emails = Array.new(50).map { "user_#{SecureRandom.alphanumeric(6).downcase}@tippkick.random" }
    team_names = Array.new(10).map { "group_#{SecureRandom.alphanumeric(6)}" }

    puts 'Users'
    users = emails.map do |email|
      puts "  #{email}"
      User.create!(email: email, password: email, rooting_for_team: User::FIFA_COUNTRY_CODES.sample)
    end

    puts
    puts 'Predict games'
    ActiveRecord::Base.connection.execute(
      <<~SQL.squish
        UPDATE bets
           SET home_team_score = floor(random() * 5)
             , guest_team_score = floor(random() * 5)
         WHERE user_id IN (SELECT id
                             FROM users
                            WHERE email LIKE '%tippkick.random');
      SQL
    )

    puts
    puts 'Teams'
    team_names.each do |team_name|
      puts "  #{team_name}"
      group = Team.create!(name: team_name)
      member_count = SecureRandom.random_number(5..30)
      members = member_count.times.map { users.sample }.uniq

      coach = true

      members.each do |member|
        group.memberships.create(user: member, coach: coach)
        coach = false
      end
    end
  end

  desc 'Setup'
  task setup: :environment do
    Rake::Task['db:fixtures:load'].execute
    Rake::Task['dev:shift_tournament'].execute
    Rake::Task['dev:create_random_data'].execute
    FinalWhistleService.new.call!
  end
end
