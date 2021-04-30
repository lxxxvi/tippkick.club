class BetsStatsReflex < ApplicationReflex
  def display
    morph "#game-#{find_game.id}-bets-stats", render(BetsStatsComponent.new(game: find_game), layout: false)
  end

  private

  def find_game
    @find_game ||= Game.includes(:bets_stats).left_outer_joins(:bets_stats).find(element.dataset[:game_id])
  end
end
