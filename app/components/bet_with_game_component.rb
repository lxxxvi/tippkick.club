class BetWithGameComponent < ViewComponent::Base
  attr_reader :bet_with_game

  def initialize(bet_with_game:)
    @bet_with_game = bet_with_game
  end

  def render?
    @bet_with_game.game.kickoff_past?
  end

  def show_live?
    @bet_with_game.game.live?
  end

  def bet_home_team_score_in_brackets
    score_in_brackets(@bet_with_game.home_team_score)
  end

  def bet_guest_team_score_in_brackets
    score_in_brackets(@bet_with_game.guest_team_score)
  end

  def element_id
    "bet-with-game-#{@bet_with_game.game.uefa_game_id}"
  end

  private

  def score_in_brackets(score)
    "(#{score})"
  end
end
