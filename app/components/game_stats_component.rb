class GameStatsComponent < ViewComponent::Base
  def initialize(game, display_stats: true)
    @game = game
    @display_stats = display_stats
  end

  def display_stats?
    @display_stats
  end

  def element_id
    "game-stats-#{@game.id}"
  end
end
