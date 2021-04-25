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
end
