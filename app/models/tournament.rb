class Tournament
  FIRST_GAME = Game.ordered_chronologically.limit(1).first
  LAST_GAME = Game.ordered_antichronologically.limit(1).first

  def self.before_first_kickoff?
    FIRST_GAME.kickoff_at.future?
  end

  def self.after_first_kickoff?
    FIRST_GAME.kickoff_at.past?
  end

  def self.before_last_kickoff?
    LAST_GAME.kickoff_at.future?
  end

  def self.after_last_kickoff?
    LAST_GAME.kickoff_at.past?
  end

  def self.tournament_ongoing?
    after_first_kickoff? && before_last_kickoff?
  end
end
