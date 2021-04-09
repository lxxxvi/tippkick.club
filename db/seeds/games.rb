GAMES_FIXTURE_PATH = Rails.root.join('test/fixtures/games.yml').freeze
GAMES_ATTRIBUTES = %i[uefa_game_id venue tournament_phase home_team_name guest_team_name kickoff_at].freeze

SeedGame = Struct.new(*GAMES_ATTRIBUTES) do
  def to_s
    "Uefa Game ID: #{uefa_game_id}"
  end
end

YAML.load_file(GAMES_FIXTURE_PATH).each_pair do |_fixture_key, fixture_game|
  seed_game = SeedGame.new(*fixture_game.transform_keys(&:to_sym).values_at(*GAMES_ATTRIBUTES))
  next if seed_game.uefa_game_id.nil?

  Game.find_or_initialize_by(uefa_game_id: seed_game.uefa_game_id).tap do |game|
    if game.new_record?
      game.assign_attributes(
        venue: seed_game.venue,
        tournament_phase: seed_game.tournament_phase,
        home_team_name: seed_game.home_team_name,
        guest_team_name: seed_game.guest_team_name,
        kickoff_at: seed_game.kickoff_at.utc
      )
      game.save!
      Rails.logger.info "  - #{seed_game}"
    end
  end
end
