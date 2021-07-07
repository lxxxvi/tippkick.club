class Tournament
  def self.first_game
    Game.find_by(uefa_game_id: '1')
  end

  def self.last_game
    Game.find_by(uefa_game_id: '51')
  end

  def self.before_first_kickoff?
    first_game.kickoff_at.future?
  end

  def self.after_first_kickoff?
    first_game.kickoff_at.past?
  end

  def self.before_last_kickoff?
    last_game.kickoff_at.future?
  end

  def self.after_last_kickoff?
    last_game.kickoff_at.past?
  end

  def self.tournament_ongoing?
    after_first_kickoff? && before_last_kickoff?
  end

  def self.after_last_final_whistle?
    last_game.final_whistle?
  end

  def self.after_group_phase?
    Game.find_by(uefa_game_id: '36').final_whistle_at&.past?
  end
end
