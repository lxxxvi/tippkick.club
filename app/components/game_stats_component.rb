class GameStatsComponent < ViewComponent::Base
  def initialize(game:)
    @game = game
  end

  def bets_stats_element_id
    "game-#{@game.id}-bets-stats"
  end
end
