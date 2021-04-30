class BetsStatsComponent < ViewComponent::Base
  delegate :bets_count, to: :@game

  def initialize(game:)
    @game = game
  end

  def bets_stats
    @bets_stats ||= @game.bets_stats.ordered_by_scores
  end
end
